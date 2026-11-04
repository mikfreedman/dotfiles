# dotfiles

Managed with [chezmoi](https://www.chezmoi.io). The source tree is `home/` (see `.chezmoiroot`).

## Install

macOS:

```sh
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
chezmoi init --apply <repo-url>
```

Linux (apt-based; the setup scripts use apt, so Homebrew isn't needed):

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <repo-url>
```

You're asked three questions once per machine: git name, git email, and whether this is a
**server** (Vim only: no Neovim, GUI apps, delta or Neovim/Neovide config). After that,
`chezmoi apply` brings a machine up to date and is safe to re-run.

`<repo-url>` is wherever this repo is hosted: any URL `git clone` accepts. To use a checkout
you already have instead, run `chezmoi init --apply --source <path-to-checkout>`.

## What's in it

| Source | Result |
|---|---|
| `dot_zshrc`, `dot_zprofile`, `dot_zshenv`, `dot_zlogin` | zsh, no framework: plain options and completion plus [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) |
| `dot_gitconfig.tmpl`, `dot_fzfrc` | git (name/email from your answers), fzf |
| `dot_config/starship.toml` | [starship](https://starship.rs) prompt |
| `dot_config/ghostty/config.ghostty` | [Ghostty](https://ghostty.org) terminal (not on servers) |
| `dot_vimrc`, `dot_gvimrc`, `dot_vim/`, `dot_config/nvim/` | Vim and Neovim, see [docs/vim.md](docs/vim.md) |
| `.chezmoiexternal.toml.tmpl`, `.chezmoidata/{vim,zsh}_plugins.yaml` | Vim and zsh plugins (pinned to commits) |
| `.chezmoidata/packages.yaml` | brew/apt package lists and pinned Linux tool versions |
| `run_*` scripts | install packages (Homebrew/apt), mise + Neovim + tree-sitter + Nerd Font on Linux, Vim helptags, Neovim plugins, login shell |

The `run_onchange_*` scripts re-run only when the package lists, pinned versions, plugin pins
or `lazy-lock.json` change.

## Everyday

```sh
chezmoi edit ~/.zshrc      # edit the source copy
chezmoi diff               # preview
chezmoi apply              # apply
chezmoi cd                 # shell in the source dir
scripts/update-plugin-pins # bump Vim and zsh plugin pins to upstream HEAD
```

Machine-local zsh settings go in `~/.zshrc.local`.
