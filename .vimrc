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
"


nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap  ` :NERDTree<CR>
nnoremap pp "0p

" User rg insead of vim search
if executable('ag')
	set grepprg=ag\ --color=never
	let g:ctrlp_user_command = 'ag %s --files --color=never --glob ""'
endif

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"colors
set wildignore+=*/.git/*,*/tmp/*,*.swp
set t_Co=256
syntax on
colorscheme fairyfloss2

"store backups in their own directory
set backup
set backupdir=~/.vim/backups//
"store swapfiles in their own directory
set directory=~/.vim/swap//

"persistent undo
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/undo')
	silent !mkdir ~/.vim/undo > /dev/null 2>&1
	set undodir=~/.vim/undo//
	set undofile
endif
	
"make tab 2 spaces
filetype plugin indent on
"show existing tab with 2 spaces width
set tabstop=2
"indent is 2 spaces
set shiftwidth=2
"tab = 2 spaces
set expandtab

" matchit
filetype plugin on
runtime macros/matchit.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'ap/vim-buftabline'
Bundle 'vim-scripts/taglist.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-surround'
Bundle 'ternjs/tern_for_vim'
Bundle 'vim-syntastic/syntastic'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'posva/vim-vue'
Bundle 'prettier/vim-prettier'
Bundle 'takac/vim-hardtime'
Bundle 'vim-scripts/RltvNmbr.vim'

call vundle#end()			

"close if just NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | e ndif
"set filetype=txt if new file
autocmd bufenter * if &filetype == "" | setlocal ft=text | endif 


"for basic text file syntax
"au BufRead,BufNewFile * setfiletype txt
"vue syntax
au BufRead,BufNewFile *.vue setfiletype vue

"skeleton files
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.vue 0r ~/.vim/templates/skeleton.vue
  augroup END
endif

" set up aliasing
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
		\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
		\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
" aliases
call SetupCommandAlias("fp","echo expand('%:p')")

" enable relative numbers too
autocmd VimEnter * RltvNmbr

" enable HARDTIME by default
" let g:hardtime_default_on = 1
" let g:hardtime_showmsg = 1
