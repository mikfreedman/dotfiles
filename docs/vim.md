# Vim and Neovim

One set of keybindings for **Vim** (servers) and **Neovim** (main machine). Installed by
chezmoi; see the top-level README for setup.

```
~/.vim/core.vim        shared options, keymaps, autocmds - plain Vimscript, no plugins needed
~/.vim/tabline.vim     numbered tabs
~/.vim/fallback.vim    Vim-only: plain versions of the picker/grep/file-tree keys
~/.vimrc, ~/.gvimrc    Vim entry points
~/.config/nvim/        Neovim entry point (init.lua sources ~/.vim/core.vim, then lazy.nvim)
```

In the source tree these are `home/dot_vim`, `home/dot_vimrc`, `home/dot_config/nvim`.
Vim plugins are pinned in `home/.chezmoidata/vim_plugins.yaml`; Neovim plugins in
`home/dot_config/nvim/lazy-lock.json`.

## Install notes

`chezmoi apply` installs everything (packages, Neovim, tree-sitter CLI, BlexMono Nerd Font,
plugins). Answer "yes" to the *server* prompt on a box that should get Vim only (no Neovim,
no GUI config). On Linux, Neovim and the tree-sitter CLI are pinned releases in `~/.local`
(distro packages are too old); make sure `~/.local/bin` is on your `PATH`.

Language servers come from [mason](https://github.com/mason-org/mason.nvim), which needs
`node`/`npm` (TypeScript, ESLint, YAML, JSON, Bash, prettier) and `go` (gopls, goimports).
On macOS both come from Homebrew. On Linux the distro `nodejs` is usually too old, so use
mise, which chezmoi installs: `mise use -g node@lts go@latest`. `rustfmt` comes from `rustup`.

The first time you open `nvim` it installs the Tree-sitter parsers and language servers in
the background; give it a minute, then run `:checkhealth`.

### GUI (Neovide)

[Neovide](https://neovide.dev) is the GUI, replacing MacVim. It's installed from the
`neovide-app` cask (the `neovide` formula builds from source).

Neovide doesn't bundle Neovim. It runs the `nvim` that chezmoi installed, so it uses the
same config and plugins. The cask also adds a `neovide` command (`neovide file.ts`). The old
MacVim Cmd-key bindings work in Neovide too.

If you still have MacVim installed, remove it with whichever of these matches how it was installed:

```sh
brew uninstall macvim            # formula
brew uninstall --cask macvim-app # cask
```

Keep Homebrew's `vim`. `command vim` loads exactly what your servers get, so you can test the
server setup locally.

### Using Neovim as `vim`

`dot_zshrc` aliases `vim`/`vi`/`vimdiff` to Neovim and sets `EDITOR`/`VISUAL` when `nvim` is
installed, so servers keep plain Vim. Type `command vim` or `\vim` to get the real Vim.

### Terminal font

Ghostty is already set to **BlexMono Nerd Font** (`~/.config/ghostty/config.ghostty`); set any
other terminal to it yourself. Over SSH it's your *local*
terminal that draws the glyphs, so icons work on servers too. If you're on a terminal without
a Nerd Font, `export NVIM_NO_NERD_FONT=1`.

Neovide and MacVim pick the font up from `~/.config/nvim/lua/config/neovide.lua` and `gvimrc`.

## Updating

- **Neovim plugins:** `:Lazy update`, try it, then `chezmoi re-add ~/.config/nvim/lazy-lock.json`
  and commit. On another machine `chezmoi apply` runs `:Lazy restore` when the lockfile changes.
- **Vim plugins:** `scripts/update-vim-pins`, review the diff, commit, `chezmoi apply`.
- **Language servers/formatters:** `:Mason`.

Machine-local overrides go in `~/.vimrc.local`, `~/.gvimrc.local` or `~/.config/nvim-local.lua`.

## Keys

Leader is `,` (local leader `;`). In Neovim, press `,` and wait for a which-key popup.

| Keys | What | Vim | Neovim |
|---|---|---|---|
| `kj` | Leave insert mode | ✓ | ✓ |
| `<Space>` | Clear search highlight | ✓ | ✓ |
| `<C-h/j/k/l>`, `,w`, `,j`, `,k` | Move between windows | ✓ | ✓ |
| `,v` | Vertical split | ✓ | ✓ |
| `,s` | `:%s/` (`:s/` in visual) | ✓ | ✓ |
| `,e` | Alternate file | ✓ | ✓ |
| `,f` | Find file | fzf.vim, or `:find` | fzf-lua |
| `,b` | Buffers | fzf.vim, or `:ls` | fzf-lua |
| `,o` | Recent files | fzf.vim, or `:browse oldfiles` | fzf-lua |
| `,a` | Grep word under cursor / selection | `:grep` (ripgrep) → quickfix | fzf-lua |
| `,A` | Live grep | `:Rg` | fzf-lua |
| `\` / `\|` | File tree / reveal current file | netrw | neo-tree |
| `-` | Open the file's directory as an editable buffer | – | oil.nvim |
| `,/` (`gc`, `gcc`) | Toggle comment | ✓ | ✓ |
| `,g` | Git blame | fugitive | fugitive |
| `,u` | Undo tree | ✓ | ✓ |
| `,t` / `,T` | Run nearest test / test file | vim-test | vim-test |
| `,=`, `F7` | Re-indent whole file | ✓ | ✓ |
| `,C` | Copy `path:line` to clipboard | ✓ | ✓ |
| `,re` / `,rv` | Edit / reload config | ✓ | ✓ |
| `<Tab>` / `<S-Tab>` (visual) | Indent / unindent | ✓ | ✓ |
| `[q ]q [b ]b ...` | Quickfix / buffer navigation (unimpaired) | ✓ | ✓ |
| `cs"'`, `ysiw)`, ... | Surround | ✓ | ✓ |
| `,,` | Shell command | ✓ | ✓ |

Neovim only:

| Keys | What |
|---|---|
| `gd` / `gD` | Go to definition / declaration |
| `K` | Hover docs |
| `grn` / `gra` / `grr` / `gri` | Rename / code action / references / implementation |
| `[d` / `]d`, `,d`, `,D` | Previous/next diagnostic, line diagnostics, all diagnostics |
| `,cf` | Format (also runs on save) |
| `]h` / `[h`, `,cs` / `,cr` / `,cp` / `,cb` | Next/prev git hunk; stage / reset / preview / line blame |
| `vaf` `dif` `cia` ... | Select function / class (`c`) / argument (`a`) by syntax tree |
| `]f` / `[f` | Next / previous function |
| `,h`, `,.` | Search help, resume last picker |
| `<C-n>`/`<C-p>`, `<C-y>`, `<C-e>` | Completion: move, accept, dismiss |

In GUIs (MacVim, Neovide), the old Cmd-key bindings also work: `⌘/`, `⌘e`, `⌘N`, `⌘⇧C`,
`⌘<`, `⌘z`/`⌘⇧Z`, `⌥⌘` + arrows.
Neovide also has `⌘s` (save), `⌘c` (copy selection) and `⌘v` (paste).

Text objects to remember: `ci"` changes what's inside quotes. `ca"` also deletes the space
before the opening quote, which is standard Vim behavior. To swap the quote style, use
`cs"'` instead.

## Changes from the old Pivotal config

- **Plugin management.** Pathogen and git submodules are gone. The `git://` URLs had stopped
  working, and some plugins had been copied into the repo with no version info. Neovim now uses
  lazy.nvim with a lockfile. Vim uses native packages pinned in `vim/plugins.txt`.
- **Ruby removed.** vim-rails, vim-ruby, cucumber, haml, slim, endwise, the Ruby snippets,
  `RunTests`/`RunFocusedTest`, `CucumberFindUnusedSteps`, the Rails ctags maps (`,rt`, `,T`)
  and the `=>` insert map.
- **Replaced plugins.**

  | Old | New |
  |---|---|
  | Command-T, FuzzyFinder | fzf-lua (Neovim) / fzf.vim (Vim) |
  | ack.vim | ripgrep |
  | NERDTree | neo-tree + oil.nvim (Neovim) / netrw (Vim) |
  | NERDCommenter | built-in `gc` |
  | Gundo | undotree |
  | Syntastic | built-in LSP + mason + conform |
  | snipMate | blink.cmp + friendly-snippets |
  | autoclose | mini.pairs |
  | Solarized | base16-railscasts (tinted-vim) |
  | Old test runner | vim-test |

- **Keys.**
  - Edit config moved to `,re` (it was `⌘<` only). Reload is still `,rv`.
  - `,g` now runs `:Git blame` (fugitive renamed `:Gblame`).
  - The FuzzyFinder keys (`,n`, `,rf`) are gone; `,f` and `,b` cover them.
  - New: `,o` recent files, `,A` live grep, `,t`/`,T` run tests, `-` oil, plus the
    Neovim-only keys above.
- **Behavior.**
  - Search is case-insensitive unless you type a capital. The old config set `smartcase`
    without `ignorecase`, so `smartcase` never did anything.
  - Mappings time out after 300ms (it was `notimeout`), so `k` in insert mode no longer
    hangs while Vim waits to see if you meant `kj`.
  - Undo history persists across sessions (`undofile`).
  - Swap and undo files live in `~/.local/state/vim` (Vim) or `~/.local/state/nvim`
    (Neovim), not `~/.vim-tmp`.
  - Trailing whitespace is stripped on save for current languages (TS/JS, Go, Rust, shell,
    YAML, ...), not Markdown.
  - The jQuery/Underscore surround targets (`$`, `_`) and the JSON-as-JavaScript filetype
    hack are gone.
