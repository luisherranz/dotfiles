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
Plug 'rakr/vim-one'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
call plug#end()

" True colors
if (has("termguicolors"))
  set termguicolors
endif

" Theme
colorscheme one
set background=light

" Use relative numbers
set number relativenumber

" Use jk (not used right now because I use BTT)
imap jk <Esc>

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

" Fix markdown comments
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->

" Use o to do bold in markdown with vim-surround
let g:surround_{char2nr('o')} = "**\r**"

" Firenvim config
if exists('g:started_by_firenvim')
  au BufEnter github.com_*.txt set filetype=markdown
  au BufEnter mail.google.com_*.txt set filetype=markdown
  au BufEnter community.frontity.org_*.txt set filetype=markdown
  au BufEnter app.frontapp.com*.txt set filetype=markdown
  au BufEnter app.slack.com*.txt set filetype=markdown

	set guifont=Monaco:h10

  " Fix double line breaks in Front and Slack
  autocmd BufEnter app.frontapp.com_* :%s/\n\n\n/\r\r/g
  autocmd BufEnter app.slack.com_* :%s/\n\n\n\n/\r/g

  autocmd BufEnter app.slack.com_* :cnoreabbrev wq %s/\n\n/\r/ge<bar>w<bar>q
  autocmd BufEnter app.slack.com_* :cnoreabbrev q %s/\n\n/\r/ge<bar>w<bar>q
  autocmd BufEnter app.slack.com_* :cnoreabbrev ZZ :g/^\s*$/d<bar>ZZ<bar>

  let g:auto_save = 1  " enable AutoSave 
  let g:auto_save_silent = 1  " do not display the auto-save notification

  " Paste
  inoremap <D-v> <C-r>+
  nnoremap <D-v> "+p
  vnoremap <D-v> "+p

  let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype', ] ],
      \   'left': [ [ 'mode', 'paste' ],
      \             [ ] ]
      \ },
      \ }

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


