## dotfiles の管理方針

- ツールごとにディレクトリを分ける（例：`claude/`、`git/`、`zsh/`）
- ディレクトリ名はドットなし（`.claude/` ではなく `claude/`）
- シンボリックリンクはディレクトリ単位ではなく**ファイル単位**で貼る

## AI への指示

管理対象ファイルを追加・変更した場合は、必ず以下を更新すること：

1. **CLAUDE.md** の「現在管理しているファイル」テーブル
2. **README.md** のセットアップコマンドと構成テーブル

## 現在管理しているファイル

| リポジトリ内のパス | リンク先 |
|---|---|
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/settings.json` | `~/Library/Application Support/Cursor/User/settings.json` |
