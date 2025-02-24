" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged') 
" C++ related plugins 
Plug 'scrooloose/nerdtree'        " File explorer 
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
Plug 'lukas-reineke/indent-blankline.nvim' "Indent guides
Plug 'tpope/vim-obsession'        " Save session :Obsess on, :Obsess! off
Plug 'RRethy/vim-illuminate'      " Illuminates word under cursor
Plug 'ggandor/leap.nvim'          " Simplified vim motions
Plug 'tpope/vim-surround'         " Easily surround text with whatever symbol

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
set ignorecase
set smartcase " case insensetive search if search input all lowercase. Depend: ignorecase
syntax enable on
set clipboard+=unnamedplus 
set cursorline 
set cursorcolumn
set laststatus=2
set path=/usr/include
set t_vb= " Turns off the bell sound
set cc=80
set tabstop=2 " Google style compliance
set shiftwidth=2 " Google style compliance
set autoread    " Reads text after switching branch
set signcolumn=yes  " Always show the sign column to prevent jumps while typing
set updatetime=300
set hidden          " Prevent coc nvim freezing
autocmd FileType c,cpp,cc,h setlocal commentstring=//\ %s " Set commenting style

" ---------- General remapping -------------------

" Resize panes using Ctrl + Left/Right
nnoremap <C-h> :vertical resize -2<CR>
nnoremap <C-l> :vertical resize +2<CR>
nnoremap <C-k> :horizontal resize +2<CR>
nnoremap <C-j> :horizontal resize -2<CR>

" Remove windows line ending shortcut
nnoremap <F5> :%s/\r//<CR>

" -------- NERDTree settings -------------------
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

"--------- Colorscheme settings ----------------
set termguicolors
colorscheme gruvbox
let g:gruvbox_transparent_bg=1
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
highlight Normal guibg=NONE ctermbg=NONE

"------------ ALE -----------------------------
let g:ale_disable_lsp = 1 " This is absolutely NEEDED to avoid conflicts with coc-nvim
let g:ale_enabled = 1

"------------COC VIM settings-------------------
let g:coc_global_extensions = ['coc-clangd', 'coc-json', 'coc-prettier']
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

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" " Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> to scroll float windows/popups
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" coc-clangd specific mapping
nnoremap <silent> <C-s> :CocCommand clangd.switchSourceHeader<CR>

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
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'c', 'cpp', 'vim', 'vimdoc', 'bash', 'python', 'yaml' },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true }
}
EOF

"-----------Indent blanklines------------------
" lua require("ibl").setup()
lua << EOF
 local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
EOF

"-----------Vim Illuminates------------------
lua << EOF
require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    delay = 0,
    filetype_overrides = {},
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = false,
    large_file_cutoff = 10000,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
    should_enable = function(bufnr) return true end,
    case_insensitive_regex = false,
    disable_keymaps = false,
})
  -- change the highlight style
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  
  --- auto update the highlight style on colorscheme change
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = { "*" },
    callback = function(ev)
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end
})
EOF

"--------- NVIM LEAP--------------------------
lua require('leap').create_default_mappings()
