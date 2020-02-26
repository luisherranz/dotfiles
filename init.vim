call plug#begin()
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-cutlass'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
call plug#end()

" Use relative numbers
set number relativenumber

" Yank to the clipboard
set clipboard=unnamedplus

" Use gc to toggle comments in VSCode
if exists('g:vscode')
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
endif

" Set leader to Space
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

" Use x to cut
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D

