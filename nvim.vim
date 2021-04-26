"Plugin
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tomasiser/vim-code-dark'
call plug#end()

"General
set title
set ruler
set number
set showcmd
set noshowmode
set wildmenu
set cmdheight=2
set laststatus=2
set shortmess+=c
set foldmethod=syntax
set foldcolumn=1
set signcolumn=yes
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set backspace=indent,eol,start
set completeopt=menuone,noinsert,noselect
set switchbuf=usetab,newtab
set history=1000
set encoding=utf8
set updatetime=300
set nobackup
set nowritebackup
if has('mouse')
  set mouse=a
endif
colorscheme codedark

"Option
let g:promptline_powerline_symbols = 0
let g:promptline_theme = 'airline'
let g:promptline_preset = {
\ 'a': [promptline#slices#cwd()],
\ 'b': [promptline#slices#vcs_branch()],
\ 'c': [promptline#slices#jobs()],
\ 'warn': [promptline#slices#last_exit_code()]
\ }
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = {
\ 'a': ['#S'],
\ 'win': ['#I:#W#F'],
\ 'cwin': ['#I:#W#F'],
\ 'options': {
\   'status-justify': 'left'
\ }
\ }
let g:coc_global_extensions = [
\ 'coc-highlight',
\ ]

"Keymap
let mapleader = ' '
nnoremap <space> <nop>
inoremap jk <esc>
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : <SID>check_back_space() ? "\<tab>" : coc#refresh()
inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<cr>"
nnoremap <silent><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
nnoremap <silent><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
inoremap <silent><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<c-f>"
inoremap <silent><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<c-b>"
vnoremap <silent><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
vnoremap <silent><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
nnoremap <silent> K :call <SID>show_documentation()<cr>
nmap <silent> <leader>q :NERDTreeTabsToggle<cr>
nmap <silent> <leader>p :CocList<cr>
nmap <silent> <leader>w :Files<cr>
nmap <silent> <leader>o :GFiles<cr>
nmap <silent> <leader>i :Buffers<cr>
nmap <silent> <leader>g :Lines<cr>
nmap <leader>f :Rg<space>
nmap <leader>a <Plug>(coc-codeaction)
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>aa <Plug>(coc-format)
xmap <leader>aa <Plug>(coc-format-selected)
nmap <leader>ar <Plug>(coc-rename)
nmap <leader>af <Plug>(coc-fix-current)
nmap gd <Plug>(coc-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap gy <Plug>(coc-type-definition)

"Command
command! -bang -nargs=* Rg
\ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1, fzf#vim#with_preview(), <bang>0)

"Autocmd
augroup user
autocmd!
autocmd BufReadPost *
\ if line('''"') > 1 && line('''"') <= line('$') |
\   exe 'normal! g`"' |
\ endif
autocmd Syntax,FileType *
\ silent! %foldopen!
autocmd BufEnter *
\ if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') |
\   q |
\ endif
autocmd CursorHold *
\ silent call CocActionAsync('highlight')
augroup end

"Function
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction
