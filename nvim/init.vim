" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged') 
" C++ related plugins 
Plug 'scrooloose/nerdtree'        " File explorer 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder 
Plug 'junegunn/fzf.vim'           " FZF commands for Vim 
Plug 'itchyny/lightline.vim'      " Lightweight satusline 
Plug 'dense-analysis/ale'         " Syntax checker
Plug 'airblade/vim-gitgutter'     " Git diff in the gutter 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-fugitive'         " Git commands

call plug#end() 

" General settings 
filetype plugin indent on
set nocompatible 
set t_Co=256
set encoding=utf-8 
set number 
set relativenumber 
set expandtab 
set autoindent 
set smartindent 
syntax enable on
set clipboard=unnamedplus 
set cursorline 
set laststatus=2
colorscheme gruvbox
set path=/usr/include
set t_vb=
set cc=80
set tabstop=2 " Google style compliance
set shiftwidth=2 " Google style compliance
set autoread    " Reads text after switching branch
 
" -------- NERDTree settings -------------------
map <C-n> :NERDTreeToggle<CR>

" COC VIM settings
let g:coc_global_extensions = ['coc-clangd']
" Tab completation
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif


" -----------LIGHTLINE SETTINGS----------------
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' , 'gitbranch'],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status',
\   'gitbranch': 'FugitiveHead'
\ },
\ }
" ----------TREESITTER SETTINGS---------------
" Enable treesitter highlighting syntax
"
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
