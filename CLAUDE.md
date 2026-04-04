## dotfiles の管理方針

- ツールごとにディレクトリを分ける（例：`claude/`、`git/`、`zsh/`）
- ディレクトリ名はドットなし（`.claude/` ではなく `claude/`）
- シンボリックリンクはディレクトリ単位ではなく**ファイル単位**で貼る

## ファイル固有のルール

- `claude/settings.json` の `permissions` 内の全項目（`allow`・`deny`・`ask`）は**アルファベット順**を維持すること

## AI への指示

管理対象ファイルを追加・変更した場合は、必ず以下を更新すること：

1. **CLAUDE.md** の「現在管理しているファイル」テーブル
2. **README.md** のセットアップコマンドと構成テーブル

## 現在管理しているファイル

| リポジトリ内のパス | リンク先 |
|---|---|
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |
| `homebrew/Brewfile` | `brew bundle` で使用（リンク不要） |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/settings.json` | `~/Library/Application Support/Cursor/User/settings.json` |
| `warp/keybindings.yaml` | `~/.warp/keybindings.yaml` |
| `mise/config.toml` | `~/.config/mise/config.toml` |
