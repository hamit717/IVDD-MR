#!/usr/bin/env bash
# ============================================================
# 一键把 IVDD-MR 仓库推到 GitHub（新建仓库 → 添加 remote → 推送）
#
# 用法（在「终端」App 里运行，不要在这里的对话框里跑，因为它要你输入令牌）：
#     bash ~/WorkBuddy/2026-11-07-22-16-25/IVDD-MR/scripts/publish_to_github.sh
#
# 也可以预先设好环境变量后非交互运行：
#     GITHUB_USER=xxx GITHUB_TOKEN=ghp_xxx bash scripts/publish_to_github.sh
#
# 令牌要求（GitHub → Settings → Developer settings → Personal access tokens）：
#   · Fine-grained token，Repository access 选 All repositories 或仅 IVDD-MR
#   · Permissions: Contents = Read and write；Administration = Read and write（要新建仓库才需要）
#   · 有效期建议 7 天，推完就可以删除
# ============================================================
set -euo pipefail

REPO_NAME="${REPO_NAME:-IVDD-MR}"
VISIBILITY="${VISIBILITY:-public}"          # public 或 private
DESC="Analysis code and summary statistics: site-resolved plasma proteome-wide MR of intervertebral disc disorders"

cd "$(dirname "$0")/.."
ROOT="$(pwd)"
echo "仓库目录: $ROOT"
echo

if [[ -z "${GITHUB_USER:-}" ]]; then
  read -r -p "GitHub 用户名: " GITHUB_USER
fi
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  read -r -s -p "粘贴 Personal Access Token（输入时不显示）: " GITHUB_TOKEN
  echo
fi

if ! curl -s -o /dev/null -w '%{http_code}' -H "Authorization: Bearer $GITHUB_TOKEN" \
     https://api.github.com/user | grep -q '^200$'; then
  echo "✗ 令牌无效或没有基础权限，请重新生成。" >&2
  exit 1
fi
echo "✓ 令牌有效，账号: $GITHUB_USER"

# ---- 1. 建仓库（已存在则跳过）----
code=$(curl -s -o /tmp/gh_repo.json -w '%{http_code}' -X POST \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d "$(printf '{"name":"%s","description":"%s","private":%s,"has_issues":true,"has_wiki":false}' \
        "$REPO_NAME" "$DESC" "$([[ $VISIBILITY == private ]] && echo true || echo false)")")

if [[ "$code" == "201" ]]; then
  echo "✓ 已创建仓库 $GITHUB_USER/$REPO_NAME（$VISIBILITY）"
elif [[ "$code" == "422" ]]; then
  echo "• 仓库已存在，继续推送"
else
  echo "✗ 建仓库失败（HTTP $code）：" >&2; cat /tmp/gh_repo.json >&2; exit 1
fi

# ---- 2. 配置 remote 并推送 ----
REMOTE="https://github.com/$GITHUB_USER/$REPO_NAME.git"
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE"
else
  git remote add origin "$REMOTE"
fi

git add -A
if ! git diff --cached --quiet; then
  git -c user.name="$GITHUB_USER" -c user.email="$GITHUB_USER@users.noreply.github.com" \
      commit -m "Update manuscript, declarations and figure legends" >/dev/null
  echo "✓ 已提交本次改动"
fi
git branch -M main

# 令牌只在本条命令内通过环境变量传给 credential helper，不写入 .git/config
GIT_TERMINAL_PROMPT=0 \
git -c credential.helper='!f() { echo username=$GITHUB_USER; echo password=$GITHUB_TOKEN; }; f' \
    push -u origin main

echo
echo "============================================================"
echo "完成。仓库地址： https://github.com/$GITHUB_USER/$REPO_NAME"
echo
echo "接下来两件事："
echo "1) 回填 URL（在项目目录执行，把 <用户名> 换成 $GITHUB_USER）："
echo "     cd \"$ROOT\""
echo "     ./scripts/set_repo_url.py $GITHUB_USER"
echo "2) 打 release 拿 DOI（期刊要 frozen release）："
echo "     打开 https://github.com/$GITHUB_USER/$REPO_NAME/releases/new"
echo "     tag 填 v1.0.0，标题填 Manuscript v1.0.0，发布后按提示在 Zenodo 授权即可拿到 DOI"
echo "3) 在 GitHub 网页删掉刚才那个令牌：Settings → Developer settings → Tokens"
echo "============================================================"
