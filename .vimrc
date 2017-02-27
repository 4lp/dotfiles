set nocompatible              " be iMproved, required
set number                    "I like line numbers
filetype off                  " required
 
let g:digital_cheetah_sites='/home/mike/sites/'
 
colorscheme molokai
set background=dark

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'git@bitbucket.org:digitalcheetah/digital-cheetah-vim.git'
Bundle 'scrooloose/nerdtree'

call vundle#end()

filetype plugin indent on

"autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | e ndif                                                                                                                                                            
