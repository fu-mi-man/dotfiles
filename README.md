## 概要

個人の設定ファイルを管理するリポジトリ。

## セットアップ

**1. Homebrew パッケージを一括インストール**

```sh
brew bundle --file=~/dev/dotfiles/homebrew/Brewfile
```

**2. mise で Node をセットアップ**

```sh
# シェルに mise を有効化（~/.zshrc に追記）
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc

# Node をインストールしてグローバルに設定
mise install node@24
mise use -g node@24
```

**3. ファイル単位でシンボリックリンクを貼る**

```sh
# Claude Code
ln -sf ~/dev/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dev/dotfiles/claude/statusline.sh ~/.claude/statusline.sh

# VSCode / Cursor（共通設定）
ln -sf ~/dev/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dev/dotfiles/vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json

# Warp
mkdir -p ~/.warp
ln -sf ~/dev/dotfiles/warp/keybindings.yaml ~/.warp/keybindings.yaml
```

## 構成

| ディレクトリ | 対象ツール |
|---|---|
| `claude/` | Claude Code (`~/.claude/`) |
| `homebrew/` | Homebrew (Brewfile) |
| `vscode/` | VSCode / Cursor |
| `warp/` | Warp |

## Claude Code プラグイン

`claude/settings.json` の `enabledPlugins` で管理。

| プラグイン | 用途 |
|---|---|
| `context7` | Next.js・Tailwind・Drizzle等の最新ドキュメントを参照 |
| `security-guidance` | XSS・SQLインジェクション等の脆弱性を自動検出 |
| `typescript-lsp` | リアルタイム型チェック |
| `code-review` | コードレビュー支援 |

## Claude Code MCP サーバー

`~/.claude.json` の `mcpServers` で管理（`claude mcp add` コマンドで設定）。

| MCP | 用途 |
|---|---|
| `pencil` | Pencil（UIデザインツール）との連携 |
