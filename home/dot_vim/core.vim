" ---------------------------------------------------------------------------
" Shared core: options, keymaps and autocmds for both Vim and Neovim.
"
" Everything here must work in plain Vim with no plugins installed. Keys that
" need a picker, file tree or grep UI are defined per editor:
"   Vim:     vim/fallback.vim
"   Neovim:  nvim/lua/plugins/*.lua
" ---------------------------------------------------------------------------

if !has('nvim')
  set nocompatible
  set encoding=utf-8
endif
filetype plugin indent on
syntax on

let mapleader = ","
let maplocalleader = ";"


" Options
" -------

set visualbell                  " Suppress audio/visual error bell
set timeout timeoutlen=300      " Short mapping timeout so `kj` and leader keys feel instant
set ttimeout ttimeoutlen=10     " ...and <Esc> doesn't lag in terminals
set showcmd                     " Show typed command prefixes while waiting for operator
set mouse=a                     " Mouse support in terminals

set expandtab                   " Use soft tabs
set tabstop=2                   " Tab settings
set softtabstop=2
set shiftwidth=2                " Width of autoindent
set autoindent
set smarttab                    " Use shiftwidth to tab at line beginning
set number                      " Line numbers
set nowrap                      " No wrapping
set backspace=indent,eol,start  " Let backspace work over anything

set wildignore+=tags                        " Ignore tags when globbing
set wildignore+=*/.git/*,*/node_modules/*   " ...and dependency/VCS dirs
set wildignore+=*/target/*,*/dist/*,*/build/*

set list                        " Show trailing whitespace and tabs
if has('gui_running') || has('nvim') || &encoding ==# 'utf-8'
  set listchars=tab:»\ ,trail:·,nbsp:␣
else
  set listchars=tab:>\ ,trail:~
endif

set showmatch                   " Show matching brackets
set hidden                      " Allow hidden, unsaved buffers
set splitright                  " Add new windows towards the right
set splitbelow                  " ... and bottom
set wildmenu
set wildmode=list:longest       " Bash-like tab completion
set scrolloff=3                 " Scroll when the cursor is 3 lines from edge
set cursorline                  " Highlight current line
set laststatus=2                " Always show statusline

set incsearch                   " Incremental search
set hlsearch                    " Search with highlights by default
set ignorecase smartcase        " Case-insensitive unless the pattern has capitals
set history=1024                " History size
set autoread                    " No prompt for file changes outside Vim
set autowriteall                " Save when doing various buffer-switching things

" Persistent undo and tidy swap files. Neovim already keeps these under
" ~/.local/state/nvim; give Vim the same layout.
set swapfile
set undofile
if !has('nvim')
  let s:state = expand('~/.local/state/vim')
  for s:dir in ['swap', 'undo']
    if !isdirectory(s:state . '/' . s:dir)
      call mkdir(s:state . '/' . s:dir, 'p', 0700)
    endif
  endfor
  let &directory = s:state . '/swap//'
  let &undodir = s:state . '/undo//'
endif

" True colour where the terminal supports it (Neovim detects this itself).
if !has('nvim') && has('termguicolors') && ($COLORTERM =~# 'truecolor\|24bit' || has('gui_running'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Use ripgrep for :grep when it's installed.
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" Statusline (Neovim replaces this with lualine).
set statusline=[%n]\ %f\ %m\ %y
set statusline+=%{exists('*FugitiveStatusline')?FugitiveStatusline():''}
set statusline+=%w              " [Preview]
set statusline+=%=              " Left/right separator
set statusline+=%c,             " Cursor column
set statusline+=%l/%L           " Cursor line/total lines
set statusline+=\ %P            " Percent through file

execute 'source ' . fnameescape(expand('<sfile>:p:h') . '/tabline.vim')


" Keybindings
" -----------

" kj - The intuitive way to get out of insert mode
inoremap kj <Esc>

" Make Y consistent with D and C
nnoremap Y y$

" Search and replace
nnoremap <leader>s :%s/
xnoremap <leader>s :s/

" Split screen
nnoremap <leader>v :vsp<CR>

" Move between windows
nnoremap <leader>w <C-w>w
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Edit / reload config
nnoremap <leader>re :tabedit $MYVIMRC<CR>
if has('nvim')
  " Re-sourcing init.lua would re-run lazy.nvim; just reload the shared core.
  execute 'nnoremap <leader>rv :source ' . fnameescape(expand('<sfile>:p')) . '<CR>'
else
  nnoremap <leader>rv :source $MYVIMRC<CR>
endif

" Auto-indent whole file
nnoremap <leader>= gg=G``
nnoremap <silent> <F7> gg=G``:echo "Reformatted."<CR>

" Fast scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Indent/unindent visual mode selection with tab/shift+tab
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" Switch to the alternate (previous) file
nnoremap <leader>e :e#<CR>

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cnoremap <C-A> <Home>

" Copy current file path (and path:line) to the system clipboard
function! s:CopyToClipboard(text) abort
  let @" = a:text
  if has('clipboard') || has('nvim')
    silent! let @+ = a:text
  endif
  echo 'Copied: ' . a:text
endfunction
nnoremap <silent> <leader>C :call <SID>CopyToClipboard(expand('%') . ':' . line('.'))<CR>

" Disable middle mouse button, F1
noremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
noremap <F1> <Nop>
inoremap <F1> <Nop>

" Easy access to the shell
nnoremap <leader><leader> :!

" Recalculate diff when it gets messed up.
nnoremap du :diffupdate<CR>

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>echo<CR>

" Map Cmd-S to <F12> in iTerm2 etc. for Save.
nnoremap <F12> :w<CR>
inoremap <F12> <C-o>:w<CR>

" Comment/uncomment with the built-in `gc` operator
" (Neovim: always available. Vim 9.1+: `packadd comment` in vim/fallback.vim.)
nmap <leader>/ gcc
xmap <leader>/ gc

" Plugins shared by both editors (no-ops if the plugin isn't installed)
nnoremap <leader>g :Git blame<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>t :TestNearest<CR>
nnoremap <leader>T :TestFile<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:test#strategy = has('nvim') ? 'neovim' : 'vimterminal'


" GUI-only Cmd-key mappings (MacVim, Neovide)
" ------------------------------------------

if has('gui_running') || exists('g:neovide')
  nnoremap <D-<> :tabedit $MYVIMRC<CR>
  nnoremap <D-z> :earlier 1<CR>
  nnoremap <D-Z> :later 1<CR>
  inoremap <D-CR> <Esc>o
  nmap <D-/> <leader>/
  xmap <D-/> <leader>/
  imap <D-/> <Esc><leader>/i
  nmap <D-e> <leader>b
  nmap <D-N> <leader>f
  nnoremap <silent> <D-C> :call <SID>CopyToClipboard(expand('%'))<CR>
  nnoremap <M-D-Down> :cnext<CR>
  nnoremap <M-D-Up> :cprevious<CR>
  nnoremap <M-D-Left> :bprevious<CR>
  nnoremap <M-D-Right> :bnext<CR>
endif


" Autocommands
" ------------

" Strip trailing whitespace on save (not Markdown: two trailing spaces are a <br>)
function! StripTrailingWhitespace() abort
  let l:view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:view)
endfunction

augroup core
  autocmd!

  autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx,*.mjs,*.cjs,*.json,*.css,*.scss,*.html,*.vue,*.svelte call StripTrailingWhitespace()
  autocmd BufWritePre *.go,*.rs,*.toml,*.c,*.h,*.cpp,*.hpp call StripTrailingWhitespace()
  autocmd BufWritePre *.sh,*.bash,*.zsh,*.yml,*.yaml,*.tf,*.lua,*.vim,Dockerfile,Makefile call StripTrailingWhitespace()

  " Write all writeable buffers when leaving a buffer or losing focus.
  autocmd BufLeave,FocusLost * silent! wall

  " Unset 'list' in the fugitive status window (which usually contains tabs).
  autocmd FileType fugitive setlocal nolist
augroup END
