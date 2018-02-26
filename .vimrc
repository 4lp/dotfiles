set nocompatible	" be iMproved, required
set number		" line numbers
filetype off		" required
set hidden		" buffers can exist in background
set autoread		" autoreload files
set autoindent		" autoindent next line
set nowrap		" don't wrap lines...
set linebreak		" ...unless it's convenient
"set hlsearch		" highlight search results
set ignorecase		" turn off case for searching...
set smartcase 		" ...unless we type a capital

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap  ` :NERDTree<CR>
nnoremap pp "0p

" User rg insead of vim search
if executable('rg')
	set grepprg=rg\ --color=never
	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
endif
" Digital Cheetah custom
let g:digital_cheetah_sites='/home/mike/sites/'
" YCM conf
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_perl_checkers = ['perl']
let g:syntastic_enable_perl_checker = 1

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
set noexpandtab

" matchit
filetype plugin on
runtime macros/matchit.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'git@bitbucket.org:digitalcheetah/digital-cheetah-vim.git'
Bundle 'scrooloose/nerdtree'
Bundle 'ap/vim-buftabline'
Bundle 'vim-scripts/taglist.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-surround'
Bundle 'ternjs/tern_for_vim'
Bundle 'vim-syntastic/syntastic'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-commentary'

call vundle#end()			

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

" set up aliasing
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
" aliases
call SetupCommandAlias("fp","echo expand('%:p')")
