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

" CtrlP - map not working but that's okay!
let g:ctrlp_map = '<c-s>'
" persistent cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" User ag insead of vim search
if executable('rg')
	set grepprg=rg\ --color=never
	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
endif
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
" only index down, not up
let g:ctrlp_working_path_mode = '0'
" Digital Cheetah custom
let g:digital_cheetah_sites='/home/mike/sites/'
" YCM conf
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set wildignore+=*/.git/*,*/tmp/*,*.swp
colorscheme molokai
set background=dark
set t_Co=256
syntax on

"keep window transparency
hi Normal guibg=NONE ctermbg=NONE

"store swapfiles in their own directory
set backupdir=~/.vimbackup//
set directory=~/.vimbackup//

"persistent undo
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
	silent !mkdir ~/.vim/backups > /dev/null 2>&1
	set undodir=~/.vim/backups
	set undofile
endif
	
"make tab 4 spaces
filetype plugin indent on
"show existing tab with 4 spaces width
set tabstop=4
"indent is 4 spaces
set shiftwidth=4
"tab = 4 spaces
set expandtab

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'git@bitbucket.org:digitalcheetah/digital-cheetah-vim.git'
Bundle 'scrooloose/nerdtree'
Bundle 'ap/vim-buftabline'
Bundle 'vim-scripts/taglist.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'ternjs/tern_for_vim'
Bundle 'vim-syntastic/syntastic'

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
