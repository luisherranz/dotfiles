call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug '907th/vim-auto-save'
Plug 'joker1007/vim-markdown-quote-syntax'
call plug#end()

" Use relative numbers
set number relativenumber

" Use jk
imap jk <Esc>

" Yank to the clipboard
" set clipboard=unnamedplus

" Set leader to Space
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" Sneak
let g:sneak#use_ic_scs = 1
set ignorecase
set smartcase

" coc config
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emoji', 
  \ ]

" coc completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Markdown quote syntax
let g:markdown_quote_syntax_filetypes = {
  \ "javascript" : {
  \   "start" : "\\%(javascript\\|js\\)",
  \},
  \ "typescript" : {
  \   "start" : "\\%(typescript\\|ts\\)",
  \},
  \ "html" : {
  \   "start" : "html",
  \},
  \ "json" : {
  \   "start" : "json",
  \},
\}

" Firenvim config
if exists('g:started_by_firenvim')
  au BufEnter github.com_*.txt set filetype=markdown
  au BufEnter community.frontity.org_*.txt set filetype=markdown

	set guifont=Monaco:h10

  let g:auto_save = 1  " enable AutoSave 

	let g:firenvim_config = { 
		\ 'globalSettings': {},
		\ 'localSettings': {
			\ '.*': {
				\ 'cmdline': 'neovim',
				\ 'priority': 0,
				\ 'filetype': 'markdown',
				\ 'selector': 'textarea',
				\ 'takeover': 'never',
			\ }
		\ }
	\ }
endif

