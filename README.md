## 概要

個人の設定ファイルを管理するリポジトリ。

## セットアップ

ファイル単位でシンボリックリンクを貼る：

```sh
# Claude Code
ln -sf ~/dev/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dev/dotfiles/claude/statusline.sh ~/.claude/statusline.sh

# VSCode / Cursor（共通設定）
ln -sf ~/dev/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dev/dotfiles/vscode/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
```

## 構成

| ディレクトリ | 対象ツール |
|---|---|
| `claude/` | Claude Code (`~/.claude/`) |
| `vscode/` | VSCode / Cursor |
