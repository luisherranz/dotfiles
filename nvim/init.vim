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
Plug 'easymotion/vim-easymotion'
call plug#end()

" Set UTF8.
let $LANG='en_US.UTF-8'

" Use true colors.
if (has("termguicolors"))
  set termguicolors
endif

" Default filetype to markdown.
autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif

" Theme.
colorscheme one
set background=light

" Don't use numbers.
set nonumber norelativenumber

" Use jk to exit insert mode.
imap jk <Esc>

" Set leader to ñ.
let mapleader = "ñ"

" On pressing tab, insert 2 spaces.
set expandtab
" Show existing tab with 2 spaces width.
set tabstop=2
set softtabstop=2
" When indenting with '>', use 2 spaces width.
set shiftwidth=2

" Sneak options.
let g:sneak#use_ic_scs = 1
let g:sneak#label = 1
set ignorecase
set smartcase

" Easymotion options.
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='hklyuiopnmqwertzxcvbasdgjf'
let g:EasyMotion_use_upper = 1
nmap s <Plug>(easymotion-s)
map <SPACE> <Plug>(easymotion-prefix)

" Coc completion options.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <silent><expr> <c-space> coc#refresh()

" Prettier command.
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Coc snippets. Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Markdown quote syntax.
let g:markdown_quote_syntax_filetypes = {
  \ "javascript" : {
  \   "start" : "\\%(javascript\\|js|jsx\\)",
  \},
  \ "typescript" : {
  \   "start" : "\\%(typescript\\|ts|tsx\\)",
  \},
  \ "html" : {
  \   "start" : "html",
  \},
  \ "json" : {
  \   "start" : "json",
  \},
\}

" Fix markdown comments.
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->

" Use o to do bold in markdown with vim-surround.
let g:surround_{char2nr('o')} = "**\r**"

" Configure lightline.
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

" GhostText config using VimR.
if has("gui_vimr")
  let g:ghost_darwin_app = "VimR"
  let g:ghost_autostart = 1
  let g:ghost_cmd = 'tabedit'

  " Format document.
  nmap ﬁ :Prettier<CR>
  imap ﬁ <C-o>:Prettier<CR>

  " Close the buffer.
  nmap <D-S-k> :call FormatAndClose()<CR>
  imap <D-S-k> <C-o>:call FormatAndClose()<CR>

  function! FormatAndClose()
    " Remove doble ** in Slack.
    if match(expand("%:t"), 'slack\.com-') != -1
      :%s/\*\*/*/ge
      call GhostNotify('text_changed', bufnr())
    endif

    " Copy the text to the clipboard in Gmail.
    if match(expand("%:t"), 'mail\.google\.com-') != -1
      normal "+yae
    endif

    call GhostNotify('closed', bufnr())
  endfunction

  function! s:SetupGhost()
    " Clean Slack of HTML tags.
    if match(expand("%:t"), 'slack\.com-') != -1
        :%s/\%^<p><br><\/p>//ge
        :%s/<br><\/p>/
/ge
        :%s/<\/p>/
/ge
        :%s/<p>//ge
        :g/^\%$/d
        :%s/<\/\?ts-mention.\{-}>//ge
        :%s/<img.*data-id="\(:\w*:\)".*>/\1/ge
    endif

    " Clean Front of HTML tags.
    if match(expand("%:t"), 'frontapp\.com-') != -1
        :%s/\%^<div[^>]*><br><\/div>//ge
        :%s/<br><\/div>/
/ge
        :%s/<\/div>/
/ge
        :%s/<div.\{-}>//ge
        :g/^\%$/d
    endif

    " Clean Gmail of HTML tags.
    if match(expand("%:t"), 'mail\.google\.com-') != -1
        :%s/\%^<br>//ge
    endif

  endfunction

  augroup vim-ghost
    au!
    autocmd BufNewFile,BufRead *.txt set filetype=markdown
    au User vim-ghost#connected call s:SetupGhost()
  augroup END
endif
