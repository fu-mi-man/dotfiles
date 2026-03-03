#!/bin/bash
# ============================================================
# Claude Code カスタムステータスライン
#
# 表示:
#   📈 Context: %  |  ⏳ API: Xm Xs  |  💰 $X.XXXX
#   🌿 branch  |  📁 ~/project  |  🤖 Model  |  🏷️ vX.X.X
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
#   echo '{"model":{"display_name":"Opus"},"workspace":{"project_dir":"/home/user/my-project"},"version":"1.0.80","cost":{"total_cost_usd":0.0123,"total_api_duration_ms":138200},"context_window":{"used_percentage":42.5}}' | ./statusline.sh
#
# 参考: https://code.claude.com/docs/ja/statusline
# ============================================================
set -euo pipefail

# --- stdin から JSON を読み込む ---
input=$(cat)

# --- jq でフィールドを取得するヘルパー関数 ---
j() { echo "$input" | jq -r "$1"; }

# --- 各フィールドの取得 ---
pct=$(j '.context_window.used_percentage // 0' | cut -d. -f1)
api_ms=$(j '.cost.total_api_duration_ms // 0')
cost=$(j '.cost.total_cost_usd // 0')
git_branch=$(git branch --show-current 2>/dev/null || true)
project_dir=$(j '.workspace.project_dir // ""')
model=$(j '.model.display_name // "?"')
version=$(j '.version // ""')

# --- 値のフォーマット ---
# LC_NUMERIC=C でロケールに依存しない小数点表記を保証
cost_fmt=$(LC_NUMERIC=C printf '%.4f' "$cost")
# ミリ秒 → 分秒に変換（awk 不要・bash 算術のみ）
api_min=$((api_ms / 60000))
api_sec=$(( (api_ms % 60000) / 1000 ))
# $HOME を ~ に短縮
project_dir_short="${project_dir/#"$HOME"/~}"

# --- コンテキスト使用率に応じた色分け ---
# 緑: 50%未満 / 黄: 50-74% / 赤: 75%以上
if (( pct < 50 )); then
    color='\033[32m'
elif (( pct < 75 )); then
    color='\033[33m'
else
    color='\033[31m'
fi
reset='\033[0m'

# --- ステータスライン出力 ---
echo -e "${color}📈 Context: ${pct}%${reset} | ⏳ API: ${api_min}m ${api_sec}s | 💰 \$${cost_fmt} | 🌿 ${git_branch} | 📁 ${project_dir_short} | 🤖 ${model} | 🏷️ v${version} "
