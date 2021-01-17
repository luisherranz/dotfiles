call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'rakr/vim-one'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
call plug#end()

" Lang
let $LANG='en_US.UTF-8'

" True colors
if (has("termguicolors"))
  set termguicolors
endif

" Theme
colorscheme one
set background=light

" Don't use numbers
set nonumber norelativenumber

" Use jk 
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
let g:sneak#label = 1
set ignorecase
set smartcase

" coc completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

inoremap <silent><expr> <c-space> coc#refresh()

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc snippets - Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

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

" Configure lightline
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

" Firenvim config
if exists('g:started_by_firenvim')
  au BufEnter github.com_*.txt set filetype=markdown
  au BufEnter mail.google.com_*.txt set filetype=markdown
  au BufEnter community.frontity.org_*.txt set filetype=markdown
  au BufEnter app.frontapp.com*.txt set filetype=markdown
  au BufEnter app.slack.com*.txt set filetype=markdown
  au BufEnter wordpressvip.zendesk.com*.txt set filetype=markdown

	set guifont=Monaco:h20

  " Fix double line breaks in Front and Slack
  autocmd BufEnter app.frontapp.com_* :%s/\n\n\n/\r\r/g
  autocmd BufEnter app.slack.com_* %s/\n\n\n\n/\r/g | %s/\n-/-/g | %s/\n```/```/g

  autocmd BufEnter app.slack.com_* :cnoreabbrev wq %s/\n\n/\r/ge<bar>w<bar>q
  autocmd BufEnter app.slack.com_* :cnoreabbrev q %s/\n\n/\r/ge<bar>w<bar>q
  autocmd BufEnter app.slack.com_* :cnoreabbrev ZZ :g/^\s*$/d<bar>ZZ<bar>

  " Paste
  inoremap <D-v> <C-r>+
  nnoremap <D-v> "+p
  vnoremap <D-v> "+p

  " Copy
  vnoremap <D-c> "+y

  " Save
  inoremap <D-s> <C-o>:w<CR>
  nnoremap <D-s> :w<CR>
  vnoremap <D-s> :w<CR>


	let g:firenvim_config = { 
    \ 'globalSettings': {
      \ 'ignoreKeys': {
        \ 'all': ['<D-1>', '<D-2>', '<D-3>', '<D-4>', '<D-5>', '<D-6>', '<D-7>'],
      \ }
    \ },
		\ 'localSettings': {
			\ '.*': {
				\ 'priority': 10,
				\ 'filetype': 'markdown',
				\ 'selector': 'textarea',
        \ 'takeover': 'never',
        \ 'cmdline': 'neovim',
			\ }
		\ }
	\ }
endif

" GhostText 
if has("gui_vimr")
  let g:ghost_darwin_app = "VimR"
  let g:ghost_autostart = 1
  let g:ghost_cmd = 'tabedit'

  " Format document.
  nmap ﬁ :Prettier<CR>
  imap ﬁ <C-o>:Prettier<CR>

  function! s:SetupGhost()
    if match(expand("%:t"), 'slack\.com-') != -1
        :%s/\%^<p><br><\/p>//ge
        :%s/<br><\/p>//ge
        :%s/<\/p>//ge
        :%s/<p>//ge
        :g/^\%$/d
        :%s/<\/\?ts-mention.\{-}>//ge
        :%s/<img.*data-id="\(:\w*:\)".*>/\1/ge
    endif

    if match(expand("%:t"), 'frontapp\.com-') != -1
        nmap <D-S-k> "+yie:bd!<CR>
    else
        nmap <D-S-k> :bd!<CR>
    endif
  endfunction

  augroup vim-ghost
    au!
    autocmd BufNewFile,BufRead *.txt set filetype=markdown
    au User vim-ghost#connected call s:SetupGhost()
  augroup END
endif
