#!/bin/bash
# ============================================================
# Claude Code カスタムステータスライン (v3)
#
# 表示 (1行):
#   📈 Context: XX% | ⏳ API: Xm Xs | 💰 $X.XX | 🌿 branch | 📁 ~/project | 🤖 Model | 🏷️ vX.X.X
#
# 設定方法:
#   1. cp statusline.sh ~/.claude/statusline.sh
#   2. chmod +x ~/.claude/statusline.sh
#   3. ~/.claude/settings.json に以下を追加:
#      {
#        "statusLine": {
#          "type": "command",
#          "command": "~/.claude/statusline.sh"
#        }
#      }
#
# テスト:
#   echo '{"model":{"display_name":"Opus"},"workspace":{"project_dir":"/home/user/my-project"},"version":"1.0.80","cost":{"total_cost_usd":0.41,"total_api_duration_ms":138200},"context_window":{"used_percentage":42.5}}' | ~/.claude/statusline.sh
#
# 参考: https://code.claude.com/docs/ja/statusline
# ============================================================

command -v jq >/dev/null || { echo "jq not found"; exit 0; }

input=$(cat)
[ -z "$input" ] && exit 0

# --- jq 1回で全フィールドを一括抽出 ---
IFS=$'\t' read -r model version project_dir pct api_ms cost < <(
  echo "$input" | jq -r '[
    (.model.display_name // "?"),
    (.version // ""),
    (.workspace.project_dir // ""),
    ((.context_window.used_percentage // 0) | floor | tostring),
    ((.cost.total_api_duration_ms // 0) | floor | tostring),
    ((.cost.total_cost_usd // 0) | tostring)
  ] | @tsv'
)

pct=${pct:-0}; api_ms=${api_ms:-0}; cost=${cost:-0}

git_branch=$(git branch --show-current 2>/dev/null)

# --- フォーマット ---
LC_NUMERIC=C printf -v cost_fmt '%.2f' "$cost" 2>/dev/null || cost_fmt="0.00"
api_min=$((api_ms / 60000))
api_sec=$(( (api_ms % 60000) / 1000 ))

# --- コンテキスト色分け ---
GREEN='\033[32m' YELLOW='\033[33m' RED='\033[31m' RESET='\033[0m'
if   (( pct >= 75 )); then color=$RED
elif (( pct >= 50 )); then color=$YELLOW
else                        color=$GREEN
fi

# --- 組み立て ---
out="${color}📈 Context: ${pct}%${RESET}"
out="${out} | ⏳ API: ${api_min}m ${api_sec}s"
out="${out} | 💰 \$${cost_fmt}"
[ -n "$git_branch" ] && out="${out} | 🌿 ${git_branch}"
out="${out} | 📁 ${project_dir/#"$HOME"/~}"
out="${out} | 🤖 ${model}"
[ -n "$version" ] && out="${out} | 🏷️ v${version}"

printf '%b\n' "$out"
