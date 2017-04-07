set nocompatible              " be iMproved, required
set number		                  "I like line numbers
filetype off                  " required
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap  <Tab> :NERDTree<CR>

let g:digital_cheetah_sites='/home/mike/sites/'

colorscheme molokai
set background=dark
set t_Co=256

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'git@bitbucket.org:digitalcheetah/digital-cheetah-vim.git'
Bundle 'scrooloose/nerdtree'
Bundle 'ap/vim-buftabline'

call vundle#end()            

filetype plugin indent on    

"autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | e ndif

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
