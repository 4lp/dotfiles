set nocompatible              " be iMproved, required
set number		      " line numbers
filetype off                  " required
set hidden		      " buffers can exist in background
set autoread		      " autoreload files
set autoindent		      " autoindent next line
set nowrap		      " don't wrap lines...
set linebreak		      " ...unless it's convenient!
set hlsearch		      " highlight search results
set ignorecase		      " turn off case for searching...
set smartcase 		      " ...unless we type a capital

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap  ` :NERDTree<CR>
nnoremap pp "0p

let g:digital_cheetah_sites='/home/mike/sites/'

colorscheme molokai
set background=dark
set t_Co=256
syntax on

"store swapfiles in their own directory
set backupdir=~/.vimbackup//
set directory=~/.vimbackup//

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'git@bitbucket.org:digitalcheetah/digital-cheetah-vim.git'
Bundle 'scrooloose/nerdtree'
Bundle 'ap/vim-buftabline'

call vundle#end()            

filetype plugin indent on    

"close if just NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | e ndif
"set filetype=txt if new file
autocmd bufenter * if &filetype == "" | setlocal ft=text | endif 

au BufRead,BufNewFile * setfiletype txt
au BufRead,BufNewFile *.htm call s:MP_FILE()
fun! s:MP_FILE()
	let n = 1
	while n < 10 && n < line("$")
	      if getline(n) =~ '[<][!]--MPBLOCK:'
		      set ft=mp_html
		      return
	      endif
	      let n = n + 1
	endwhile
endfun
au! Syntax mp_html source $HOME/.vim/syntax/mp_html.vim
