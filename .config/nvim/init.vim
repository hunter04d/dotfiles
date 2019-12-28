 

filetype plugin indent on
syntax on

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set noshowmode " remove --Visual-- at the end

set relativenumber " Relative line numbers
set number " Also show current absolute line

" smart search
set ignorecase
set smartcase
set incsearch

" Keyboard
" Remap the leader key to the spacebar
let mapleader=" "

" ; instead of :
nnoremap ; :
" Remap Escape
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>



" Jump to start and end of line using the home row keys
map H ^
map L $



" Set the shell
set shell=/bin/zsh

" clipboad
set clipboard=unnamedplus

" Enable syntax highlighting
syntax on



set relativenumber " Relative line numbers
set number " Also show current absolute line
" line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END


" Permanent undoS
set undodir=~/.vimdid
set undofile

