## 概要

個人の設定ファイルを管理するリポジトリ。

## セットアップ

ファイル単位でシンボリックリンクを貼る：

```sh
ln -sf ~/dev/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dev/dotfiles/claude/statusline.sh ~/.claude/statusline.sh
```

## 構成

| ディレクトリ | 対象ツール |
|---|---|
| `claude/` | Claude Code (`~/.claude/`) |
