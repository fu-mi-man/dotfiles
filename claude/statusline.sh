#!/bin/bash
#
# Claude Code ステータスライン表示スクリプト
#
# 表示項目:
#   コンテキスト使用率 / セッションコスト / API応答時間 /
#   Gitブランチ / プロジェクトディレクトリ / モデル名 / バージョン
#
# 設定方法:
#   1. ~/.claude/statusline.sh に配置
#   2. chmod +x ~/.claude/statusline.sh
#   3. ~/.claude/settings.json に以下を追加:
#      { "statusLine": { "type": "command", "command": "~/.claude/statusline.sh" } }
#
# 参考: https://code.claude.com/docs/en/statusline

set -euo pipefail

# --- JSON入力の読み込み ---
# Claude CodeがstdinにセッションデータをJSON形式で渡す
input=$(cat)

# jqでフィールドを取得するヘルパー関数
j() { echo "$input" | jq -r "$1"; }

# デバッグ: 実際のJSONを確認したい場合は下の行のコメントを外す
# echo "$input" > /tmp/statusline_debug.json

# --- 各フィールドの取得 ---

# コンテキストウィンドウ使用率 (公式ドキュメント外・実データに存在)
# 小数点以下を切り捨てて整数にする
pct=$(j '.context_window.used_percentage // 0' | cut -d. -f1)

# セッションコスト (公式: cost.total_cost_usd)
# LC_NUMERIC=C でロケールに依存しない小数点表記を保証
cost=$(j '.cost.total_cost_usd // 0')
cost=$(LC_NUMERIC=C printf '%.4f' "$cost")

# API応答時間の合計 (公式: cost.total_api_duration_ms) をミリ秒→秒に変換
api_sec=$(j '.cost.total_api_duration_ms // 0' | awk '{printf "%.1f", $1/1000}')

# Gitブランチ (公式 Git-Aware Status Line 準拠)
# カレントディレクトリがgitリポジトリ内であればブランチ名を取得
git_branch=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    [[ -n "$branch" ]] && git_branch="$branch"
fi

# プロジェクトディレクトリ (公式: workspace.project_dir)
# $HOME を ~ に短縮して表示
project_dir=$(j '.workspace.project_dir // ""')
project_dir_short="${project_dir/#"$HOME"/~}"

# モデル表示名 (公式: model.display_name)
model=$(j '.model.display_name // "?"')

# Claude Codeバージョン (公式: version)
version=$(j '.version // ""')

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

# --- ステータスライン出力 (1行のみ) ---
echo -e "${color}📊 context: ${pct}%${reset} | 💰 cost: \$${cost} | ⚡ api: ${api_sec}s | 🌿 branch: ${git_branch} | 📁 dir: ${project_dir_short} | 🤖 model: ${model} | 📟 v${version} "
