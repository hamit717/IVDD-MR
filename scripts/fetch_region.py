#!/usr/bin/env python3
"""
按 tabix 索引从远端 GWAS Catalog harmonised 文件只取指定区域。
避免下载 306MB 全文件，单次只取几 MB。
用法: python3 fetch_region.py <gz_url> <chrom> <start> <end> <out_tsv>
"""
import sys, io, gzip, struct, subprocess, os, tempfile

PROXY = "http://127.0.0.1:7890"


def curl_range(url, start, end, out=None):
    """取 [start, end] 字节区间（含端点）。out=None 则返回 bytes。"""
    cmd = ["curl", "-s", "--max-time", "300", "--retry", "5", "--retry-all-errors",
           "-x", PROXY, "-r", f"{start}-{end}", url]
    if out:
        cmd += ["-o", out]
        subprocess.run(cmd, check=True)
        return None
    r = subprocess.run(cmd, capture_output=True, check=True)
    return r.stdout


def parse_tbi(tbi_bytes):
    """解析 .tbi，返回 (names, ref_bins, ref_linear)"""
    data = gzip.decompress(tbi_bytes)
    (magic, n_ref, fmt, col_seq, col_beg, col_end,
     meta, skip, l_nm) = struct.unpack("<4s8i", data[:36])
    assert magic == b"TBI\x01", "不是 tabix 索引"
    off = 36
    names = data[off:off + l_nm].split(b"\x00")[:-1]
    off += l_nm
    refs = []
    for _ in range(n_ref):
        n_bin, = struct.unpack("<i", data[off:off + 4]); off += 4
        bins = {}
        for _ in range(n_bin):
            bin_id, n_chunk = struct.unpack("<Ii", data[off:off + 8]); off += 8
            chunks = []
            for _ in range(n_chunk):
                b, e = struct.unpack("<QQ", data[off:off + 16]); off += 16
                chunks.append((b, e))
            bins[bin_id] = chunks
        # 紧跟该染色体的线性索引（与 bins 交替存放）
        n_intv, = struct.unpack("<i", data[off:off + 4]); off += 4
        avail = (len(data) - off) // 8
        n_read = min(n_intv, avail)
        linear = list(struct.unpack("<%dQ" % n_read, data[off:off + 8 * n_read])) if n_read > 0 else []
        off += 8 * n_intv
        refs.append((bins, linear, n_read == n_intv))
    return names, refs


def reg2bins(beg, end):
    end -= 1
    bins = [0]
    for k in range(1 + (beg >> 26), 1 + (end >> 26) + 1): bins.append(k)
    for k in range(9 + (beg >> 23), 9 + (end >> 23) + 1): bins.append(k)
    for k in range(73 + (beg >> 20), 73 + (end >> 20) + 1): bins.append(k)
    for k in range(585 + (beg >> 17), 585 + (end >> 17) + 1): bins.append(k)
    for k in range(4681 + (beg >> 14), 4681 + (end >> 14) + 1): bins.append(k)
    return bins


def main():
    url, chrom, start, end, out = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
    tbi = curl_range(url + ".tbi", 0, 20_000_000)
    names, refs = parse_tbi(tbi)
    names = [n.decode() for n in names]
    if chrom not in names:
        sys.exit(f"染色体 {chrom} 不在索引中，可选: {names[:5]}...")
    rid = names.index(chrom)
    bins, linear, _ = refs[rid]

    beg0 = max(0, start - 1)
    min_off = 0
    if linear:
        idx = beg0 >> 14
        if idx < len(linear):
            min_off = linear[idx]
    want = set(reg2bins(beg0, end))
    chunks = []
    for b, cl in bins.items():
        if b in want:
            chunks.extend(cl)
    chunks = [c for c in chunks if c[1] > min_off]
    chunks.sort()
    if not chunks:
        sys.exit("该区域无数据块")

    lo_byte = min(c[0] >> 16 for c in chunks)
    hi_byte = max(c[1] >> 16 for c in chunks) + 65536
    blob = curl_range(url, lo_byte, hi_byte)
    print(f"[下载] 压缩字节 {lo_byte}-{hi_byte} = {len(blob)/1e6:.2f} MB", file=sys.stderr)

    rows = []
    # 取文件真实表头（各研究列结构不完全一致，不能硬编码）
    HEADER = ("chromosome\tbase_pair_location\teffect_allele\tother_allele\tbeta\t"
              "standard_error\teffect_allele_frequency\tp_value\tvariant_id\trsid\tn\t"
              "hm_coordinate_conversion\thm_code")
    try:
        hb = curl_range(url, 0, 65536)
        with gzip.GzipFile(fileobj=io.BytesIO(hb)) as hf:
            first = hf.readline().decode("utf-8", "ignore").rstrip("\n")
        if first.startswith("chromosome"):
            HEADER = first
    except Exception:
        pass
    ncol = len(HEADER.split("\t"))
    seen = set()
    try:
        with gzip.GzipFile(fileobj=io.BytesIO(blob)) as f:
            for raw in f:
                line = raw.decode("utf-8", "ignore").rstrip("\n")
                parts = line.split("\t")
                if len(parts) < ncol - 1:
                    continue          # 半行/表头/异常行
                try:
                    c = parts[0]; p = int(parts[1])
                except ValueError:
                    continue
                if c == chrom and start <= p <= end:
                    key = (p, parts[2], parts[3])
                    if key in seen:
                        continue
                    seen.add(key)
                    rows.append(line)
    except (EOFError, OSError, gzip.BadGzipFile):
        pass

    with open(out, "w") as fh:
        fh.write(HEADER + "\n")
        fh.write("\n".join(rows) + ("\n" if rows else ""))
    print(f"[完成] {chrom}:{start}-{end} 取到 {len(rows)} 个变异 -> {out}", file=sys.stderr)


if __name__ == "__main__":
    main()
