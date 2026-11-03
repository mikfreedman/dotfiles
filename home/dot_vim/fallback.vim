" ---------------------------------------------------------------------------
" Plain-Vim versions of the keys Neovim gives to fancier plugins.
" Same keys, simpler tools: works on any server with Vim 9.
" ---------------------------------------------------------------------------

" Built-in optional packages
silent! packadd! matchit        " % jumps between if/else/end, HTML tags, ...
silent! packadd! comment        " gc / gcc commenting (Vim 9.1+)

" Pickers: fzf.vim when fzf is installed, otherwise :find / :ls
function! s:SetupPickers() abort
  if exists(':Files') == 2 && executable('fzf')
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>o :History<CR>
    nnoremap <leader>A :Rg<CR>
  else
    set path=.,**
    nnoremap <leader>f :find<Space>
    nnoremap <leader>b :ls<CR>:buffer<Space>
    nnoremap <leader>o :browse oldfiles<CR>
    nnoremap <leader>A :grep<Space>
  endif
endfunction
autocmd VimEnter * call s:SetupPickers()

" Grep the word under the cursor / the visual selection into the quickfix list
function! s:Grep(text) abort
  execute 'silent grep! -F -- ' . shellescape(a:text, 1)
  cwindow
  redraw!
endfunction
nnoremap <silent> <leader>a :call <SID>Grep(expand('<cword>'))<CR>
xnoremap <silent> <leader>a "xy:call <SID>Grep(@x)<CR>

" File tree: netrw in a left-hand split
let g:netrw_banner = 0
let g:netrw_liststyle = 3       " Tree view
let g:netrw_winsize = 20        " Percent of the window
nnoremap <silent> \ :Lexplore<CR>
nnoremap <silent> <Bar> :Lexplore %:p:h<CR>
