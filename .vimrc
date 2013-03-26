" pathogen.vim: manage your runtimepath
"https://github.com/tpope/vim-pathogen
"call pathogen#runtimel_append_all_bundles()

"-------------------------------------------------
"" NeoBundle プラグイン管理
"-------------------------------------------------
"""" https://github.com/Shougo/neobundle.vim
filetype off 
set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'git://github.com/Shougo/vimproc.git'
"NeoBundle 'Shougo/vimproc'

"" My Bundles here:
"" Note: You don't set neobundle setting in .gvimrc!
"" Original repos on github
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
"NeoBundle 'git://github.com/Lokaltog/powerline.git' require python support
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'

"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"" vim-scripts repos
"NeoBundle 'L9'
"NeoBundle 'FuzzyFinder'
"NeoBundle 'rails.vim'
"" Non github repos
"NeoBundle 'git://git.wincent.com/command-t.git'
"" Non git repos
"NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'


"NeoBundle 'git://github.com/tpope/vim-surround.git'
"NeoBundle 'git://github.com/tpope/vim-repeat.git'
"NeoBundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
" NeoBundle 'git://github.com/Shougo/vimshell.git'
" NeoBundle 'git://github.com/mattn/zencoding-vim.git'
" " NeoBundle 'git://github.com/c9s/perlomni.vim.git'
" NeoBundle 'git://github.com/othree/eregex.vim.git'
" NeoBundle 'QuickBuf'

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

"""" http://code-life.net/?p=2170
" 分割した設定ファイルをすべて読み込む
"set runtimepath+=~/.vim/
"runtime! userautoload/*.vim

set encoding=utf-8
"set encoding=shift_jis
set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
"set fileencodings=cp932,iso-2022-jp,utf-8,euc-jp
let $LANG='ja'


set laststatus=2
set tabstop=4       " numbers of spaces of tab character
"set shiftwidth=4    " numbers of spaces to (auto)indent
"set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
"set visualbell t_vb=    " turn off error beep/flash
"set novisualbell    " turn off visual bell
"set nobackup        " do not keep a backup file



"set directory=
set number          " show line numbers
set ignorecase      " ignore case when searching 
set smartcase
"set noignorecase   " don't ignore case
set nowrapscan
set title           " show title in console title bar
set ttyfast         " smoother changes
"set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
"set shortmess=atI   " Abbreviate messages
"set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
"set viminfo='20,<50,s10,h

"set autoindent     " always set autoindenting on
"set smartindent        " smart indent

"set statusline=%F%M%R%=code:%B%H%W "{フルパス},+,RO code:{文字コード},HLP,PRV

"set cindent            " cindent
"set noautoindent
"set nosmartindent
"set nocindent   

"set autowrite      " auto saves changes when quitting and swiching buffer
"set expandtab      " tabs are converted to spaces, use only when required
"set sm             " show matching braces, somewhat annoying...
set showmatch       " show matching braces, somewhat annoying...
set matchtime=5
set wildmenu        " コマンドライン補完するときに補完候補を表示する
set nowrap         " don't wrap lines
"set list	" タブ文字、行末など不可視文字を表示する  
"set listchars=eol:$,tab:>\ ,extends:<	" listで表示される文字のフォーマットを指定する

" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Show trailing whitepace and spaces before a tab:
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/


:autocmd BufEnter * let b:did_ftplugin = 1



""""http://vim.sourceforge.net/scripts/script.php?script_id=2204
"let twitvim_login = "tommy_io:password"
"let twitvim_login_b64 = "dG9tbXlfaW86bWkwazdhbW95bWlndTVNZQ=="
"let twitvim_count = 50 

"""" https://powerline.readthedocs.org/en/latest/overview.html 
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"""" vim-powerline
let g:Powerline_symbols = 'fancy'
set t_Co=256
"""" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
"set background=light
let g:solarized_termcolors=256
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
call togglebg#map("<F5>")
"foldmethod=marker

"-------------------------------------------------
" ユーザー定義関数
"-------------------------------------------------
 
" Paste Mode
" {{{
let paste_mode = 0 " 0 = normal, 1 = paste
 
function! Paste_on_off()
    if g:paste_mode == 0
        set paste
        let g:paste_mode = 1
    else
        set nopaste
        let g:paste_mode = 0
    endif
    return
endfunc
" }}}
"-------------------------------------------------
" Mappings キーマッピング
"-------------------------------------------------
 
"-------------------------------------------------
" Move 移動設定
"-------------------------------------------------
 
" insert mode での移動
inoremap <C-e> <END>
inoremap <C-a> <HOME>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
 
"-------------------------------------------------
" Function ユーザー定義関数
"-------------------------------------------------
 
" Paste Mode <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
".vimrc<e3><82><92>"nnoremap"で検索したときで、

"" CTRL-hjklでウィンドウ移動
nnoremap <C-j> :<C-w>j
nnoremap <C-k> :<C-k>j
nnoremap <C-l> :<C-l>j
nnoremap <C-h> :<C-h>j

"""" http://code-life.net/?p=2704
"Quick Escaping
inoremap jj <Esc>

"どこでもVimrcの編集
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
 
"Vimrcの反映
"nnoremap <leader>rv :source $MYVIMRC<CR>
