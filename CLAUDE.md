## 概要

個人の設定ファイルを管理するための dotfiles リポジトリ。Claude Code の設定を管理する。

## dotfiles の管理方針

設定ファイルはツールごとにディレクトリを分けて管理する（例：`claude/`、`git/`、`zsh/`）。
ディレクトリ名はドットなし（`.claude/` ではなく `claude/`）にする。

シンボリックリンクはディレクトリ単位ではなく**ファイル単位**で貼る：
```
~/.claude/settings.json -> ~/dev/dotfiles/claude/settings.json
~/.claude/statusline.sh -> ~/dev/dotfiles/claude/statusline.sh
```

## 現在管理しているファイル

| リポジトリ内のパス | リンク先 |
|---|---|
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/settings.json` | `~/Library/Application Support/Cursor/User/settings.json` |
