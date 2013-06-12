" Initialize:"{{{
"

if !&compatible
  " Enable no Vi compatible commands.
  set nocompatible
endif

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if exists('&regexpengine')
  " Use old regexp engine.
  " set regexpengine=1
endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

" Use English interface.
if s:is_windows
  " For Windows.
  language message en
else
  " For Linux.
  language message C
endif

" Use ',' instead of '\'.
" It is not mapped with respect well unless I set it before setting for plug in.
" Use <Leader> in global plugin.
let g:mapleader = ','
" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = 'm'

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap m  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

if s:is_windows
  " Exchange path separator.
  set shellslash
endif

" In Windows/Linux, take in a difference of ".vim" and "$VIM/vimfiles".
let $DOTVIM = expand('~/.vim')

" Because a value is not set in $MYGVIMRC with the console, set it.
if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:set_default(var, val)
  if !exists(a:var) || type({a:var}) != type(a:val)
    silent! unlet {a:var}
    let {a:var} = a:val
  endif
endfunction

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

if filereadable(expand('~/.secret_vimrc'))
  execute 'source' expand('~/.secret_vimrc')
endif

let s:neobundle_dir = expand('~/.bundle')

"-------------------------------------------------
"" NeoBundle プラグイン管理
"-------------------------------------------------
"""" https://github.com/Shougo/neobundle.vim
filetype off 
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'https://github.com/Shougo/neobundle.vim'
" NeoBundle 'https://github.com/Shougo/vimproc'
NeoBundle 'Shougo/vimproc', '', 'default'
call neobundle#config('vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ })

"" My Bundles here:
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
" NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'Shougo/unite.vim', '', 'default'
call neobundle#config('unite.vim',{
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'Unite',
      \                   'complete' : 'customlist,unite#complete_source'},
      \                 'UniteWithCursorWord', 'UniteWithInput']
      \ }})
" NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'Shougo/neocomplcache', '', 'default'
call neobundle#config('neocomplcache', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : 'NeoComplCacheEnable',
      \ }})
" NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundleLazy 'thinca/vim-ref', { 'autoload' : {
      \ 'commands' : 'Ref'
      \ }}
NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : {
      \ 'unite_sources' : ['history/command', 'history/search']
      \ }}
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/Lokaltog/powerline.git' "Need Python interpriter
"NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
"NeoBundle 'migemo', {'type' : 'nosync', 'base' : '~/.vim/bundle/manual'}
"NeoBundleLazy 'git://github.com/kakkyz81/evervim.git', {'command' : [ 'EvervimCreateNote', 'EvervimNotebookList', 'EvervimListTags', 'EvervimSearchByQuery' ] }
"NeoBundleLazy 'git://github.com/tpope/vim-rails.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/scrooloose/nerdtree'
"NeoBundle 'https://github.com/scrooloose/nerdcommenter'
"NeoBundle 'https://github.com/Lokaltog/vim-easymotion'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-l9'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'
"NeoBundle 'https://github.com/kana/vim-fakeclip'
"NeoBundle 'https://github.com/vim-scripts/mru.vim'
NeoBundle 'https://github.com/Townk/vim-autoclose'
" NeoBundle 'https://github.com/vim-ruby/vim-ruby'
NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload' : {
      \ 'mappings' : '<Plug>(ref-keyword)',
      \ 'filetypes' : 'ruby'
      \ }}
"NeoBundle 'https://github.com/msanders/snipmate.vim'
"NeoBundle 'https://github.com/pangloss/vim-javascript'
"NeoBundle 'https://github.com/jelera/vim-javascript-syntax'
NeoBundle 'https://github.com/jiangmiao/simple-javascript-indenter'
NeoBundle 'https://github.com/vim-scripts/jQuery'
" NeoBundle 'https://github.com/teramako/jscomplete-vim'
NeoBundleLazy 'teramako/jscomplete-vim', {
      \ 'autoload' : {
      \   'filetypes' : 'javascript'
      \ }}
" NeoBundle 'https://github.com/Shougo/neosnippet'
NeoBundle 'Shougo/neocomplcache-rsense', '', 'default'
call neobundle#config('neocomplcache-rsense', {
      \ 'lazy' : 1,
      \ 'depends' : 'Shougo/neocomplcache',
      \ 'autoload' : { 'filetypes' : 'ruby' }
      \ })

NeoBundle 'Shougo/neosnippet', '', 'default'
call neobundle#config('neosnippet', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'insert' : 1,
      \   'filetypes' : 'snippet',
      \   'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
      \ }})
"NeoBundle 'https://github.com/honza/snipmate-snippets'
NeoBundle 'https://github.com/majutsushi/tagbar'
"NeoBundle 'https://github.com/mattn/zencoding-vim'
"NeoBundle 'https://github.com/tyru/open-browser.vim'
"NeoBundle 'https://github.com/tyru/open-browser-github.vim'
"NeoBundle 'https://github.com/tell-k/vim-browsereload-mac'
NeoBundle 'https://github.com/vim-jp/vimdoc-ja'
NeoBundle 'https://github.com/hail2u/vim-css3-syntax'
"NeoBundle 'https://github.com/AtsushiM/sass-compile.vim'
NeoBundle 'https://github.com/kchmck/vim-coffee-script'
NeoBundle 'https://github.com/claco/jasmine.vim'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides'
"NeoBundle 'https://github.com/chazy/cscope_maps'
NeoBundle 'https://github.com/mojako/ref-sources.vim'
NeoBundle 'https://github.com/mustardamus/jqapi'
NeoBundle 'https://github.com/tokuhirom/jsref'
"NeoBundle 'https://github.com/mattn/webapi-vim'
"NeoBundle 'https://github.com/mattn/gist-vim'
"NeoBundle 'https://github.com/vim-scripts/TwitVim'
NeoBundleLazy 'basyura/TweetVim', { 'depends' :
      \ ['basyura/twibill.vim', 'tyru/open-browser.vim'],
      \ 'autoload' : { 'commands' : 'TweetVimHomeTimeline' }}
"NeoBundle 'https://github.com/msanders/cocoa.vim'
"NeoBundle 'https://github.com/terryma/vim-multiple-cursors'
NeoBundle 'https://github.com/terryma/vim-expand-region'
NeoBundle 'https://github.com/terryma/vim-smooth-scroll'
" NeoBundle 'https://github.com/kana/vim-textobj-line'
" NeoBundle 'https://github.com/kana/vim-textobj-entire'
NeoBundle 'https://github.com/osyo-manga/vim-anzu'
NeoBundle 'https://github.com/spolu/dwm.vim'
NeoBundle 'https://github.com/kannokanno/unite-dwm'
" NeoBundle 'https://github.com/Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimfiler', '', 'default'
call neobundle#config('vimfiler', {
      \ 'lazy' : 1,
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \    'commands' : [
      \                  { 'name' : 'VimFiler',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'VimFilerExplorer',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'Edit',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  { 'name' : 'Write',
      \                    'complete' : 'customlist,vimfiler#complete' },
      \                  'Read', 'Source'],
      \    'mappings' : ['<Plug>(vimfiler_switch)'],
      \    'explorer' : 1,
      \ }
      \ })
NeoBundle 'https://github.com/tpope/vim-surround'
"NeoBundle 'https://github.com/tpope/vim-speeddating'
"NeoBundle 'https://github.com/tpope/vim-abolish'
"NeoBundle 'https://github.com/tpope/vim-unimpaired'
NeoBundle 'https://github.com/tpope/vim-commentary'
NeoBundle 'https://github.com/tpope/vim-repeat'
NeoBundle 'https://github.com/fuenor/qfixgrep.git'
" NeoBundle 'https://github.com/glidenote/memolist.vim'
" NeoBundle 'https://github.com/tsukkee/unite-tag'
" NeoBundle 'https://github.com/h1mesuke/unite-outline'
NeoBundle 'Shougo/unite-outline', '', 'default'
call neobundle#config('unite-outline', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'outline'},
      \ })
NeoBundle 'https://github.com/kien/ctrlp.vim'
NeoBundle 'https://github.com/mileszs/ack.vim'
NeoBundle 'https://github.com/rking/ag.vim'
NeoBundle 'https://github.com/honza/vim-snippets/'
" NeoBundle 'https://github.com/tsukkee/unite-help'
NeoBundleLazy 'Shougo/unite-help', { 'autoload' : {
      \ 'unite_sources' : 'help'
      \ }}
NeoBundleLazy 'tsukkee/unite-tag', { 'autoload' : {
      \ 'unite_sources' : 'tag'
      \ }}
" NeoBundle 'https://github.com/kana/vim-niceblock'
NeoBundleLazy 'kana/vim-niceblock', { 'autoload' : {
      \ 'mappings' : ['<Plug>(niceblock-I)', '<Plug>(niceblock-A)']
      \ }}
NeoBundle 'Shougo/vimshell', '', 'default'
call neobundle#config('vimshell', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_switch)']
      \ }})
NeoBundleLazy 'ujihisa/unite-font', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \  'unite_sources' : 'font'
      \ }}
NeoBundleLazy 'osyo-manga/unite-quickfix', { 'autoload' : {
      \ 'unite_sources' : 'quickfix',
      \ }}
NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {
      \ 'unite_sources' : 'filetype',
      \ }}
NeoBundleLazy 'kannokanno/vimtest', { 'autoload' : {
      \ 'commands' : 'VimTest'
      \ }}
NeoBundle 'scrooloose/nerdcommenter', '', 'default'
NeoBundle 'Shougo/context_filetype.vim', '', 'default'
NeoBundleLazy 'tyru/vim-altercmd'



filetype plugin indent on
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

"""" http://d.hatena.ne.jp/thinca/20100205/1265307642
"if filereadable(expand('~/.vimrc.local'))
"	source ~/.vimrc.local
"endif

"""" http://stackoverflow.com/questions/10139972/vim-hasmacunix-or-hasmac-do-not-work
"let os=substitute(system('uname'), '\n', '', '')
"if os == 'Darwin' || os == 'Mac'
"    set guifont=Inconsolata-dz:h12
"    " more...
"elseif os == 'Linux'
"    set guifont=Inconsolata-dz\ Medium\ 10
"    " more...
"endif

set encoding=utf-8
"set encoding=shift_jis
set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
"set fileencodings=cp932,iso-2022-jp,utf-8,euc-jp
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
let $LANG='C'
"set helplang=ja,en
set helplang=en,ja


set laststatus=2
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set expandtab
"set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
"set visualbell t_vb=    " turn off error beep/flash
"set novisualbell    " turn off visual bell
"set nobackup        " do not keep a backup file
set cursorline



"set directory=
"set number          " show line numbers
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

"set cindent            " cindent
"set noautoindent
"set nosmartindent
"set nocindent   

"set autowrite      " auto saves changes when quitting and swiching buffer
"set expandtab      " tabs are converted to spaces, use only when required
set showmatch       " show matching braces, somewhat annoying...
set matchtime=5

set wildmode=longest:full,list:longest
set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

set nowrap         " don't wrap lines
"set list	" タブ文字、行末など不可視文字を表示する  
"set listchars=eol:$,tab:>\ ,extends:<	" listで表示される文字のフォーマットを指定する
set clipboard=unnamed,autoselect
"set splitbelow "新しいウィンドウを下に開く
"set splitright "新しいウィンドウを右に開く

set magic



" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Show trailing whitepace and spaces before a tab:
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/


:autocmd BufEnter * let b:did_ftplugin = 1

" Send more characters for redraws
set ttyfast

" Enable mouse use in all modes
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

"set backspace=start,eol,indent
set backspace=eol

" set conceallevel=0
highlight link HelpBar Normal
highlight link HelpStar Normal

set helpheight=30
set tags=tags
:let &keywordprg=':help'
":set keywordprg=man\ -s

" set grepprg=ag
set grepprg=jvgrep

" ステータスラインの表示
" http://blog.ruedap.com/entry/20110712/vim_statusline_git_branch_name
"set statusline&
  set statusline=%<     " 行が長すぎるときに切り詰める位置
  set statusline+=[%n]  " バッファ番号
  set statusline+=%m    " %m 修正フラグ
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fileencode, fileformat
  set statusline+=%y    " バッファ内のファイルのタイプ
  set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%l   " 何行目にカーソルがあるか
  set statusline+=/
  set statusline+=%L    " バッファ内の総行数
  set statusline+=,
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%c    " 何列目にカーソルがあるか
"  set statusline+=%V    " 画面上の何列目にカーソルがあるか
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%P    " ファイル内の何％の位置にあるか
  set statusline+=\ \   " 空白スペース2個
  set statusline+=0x%B  " 文字コード
  set statusline+=\ \   " 空白スペース2個


"-------------------------------------------------
" Mappings キーマッピング
" Key-mappings
"-------------------------------------------------
" insert mode での移動
"inoremap <C-e> <END>
"inoremap <C-a> <HOME>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>

" Tab
"nnoremap <C-n> gt
"nnoremap <C-p> gT
 
" http://archiva.jp/web/tool/how_to_vim_2.html
" https://github.com/sigwyg/Vim-Starter-kit/blob/master/.vimrc
"水平方向の移動を簡単にしてます。nowrapな時に便利。
nnoremap zl zL
nnoremap zh zH
"行移動を見た目上に行うようにしています。wrap指定している場合、見た目上は数行に改行されていても内部的には1行なので。
noremap j gj
noremap k gk
"タブ移動です。tは遠いよね ==)
"noremap gh gT
"noremap gl gt
"normalモードでもカーソル位置で改行できるようにしてます。
"noremap <CR> i<CR><ESC>
"ブラケット入力時にスムーズに編集できるように。最近びみょーかもと思い始めてますが。
"inoremap {} {}<LEFT>
"inoremap [] []<LEFT>
"inoremap () ()<LEFT>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>
"inoremap <> <><LEFT>
"inoremap []5 [%  %]<LEFT><LEFT><LEFT>
"inoremap {}5 {%  %}<LEFT><LEFT><LEFT>
"検索結果に移動したとき、その位置を画面の中央にします。上端とかに移動しても気付きにくいので。
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
"検索時、「/」の入力をエスケープします。
"cnoremap  / getcmdtype() == '/' ? '\/' : '/'
"ウィンドウ分割時にウィンドウサイズを調節する設定です。Shiftキー＋矢印キー。
"nnoremap <silent> <S-Left>  :5wincmd <<CR>
"nnoremap <silent> <S-Right> :5wincmd ><CR>
"nnoremap <silent> <S-Up>    :5wincmd -<CR>
"nnoremap <silent> <S-Down>  :5wincmd +<CR>
"バッファの一覧・移動・削除です。QuickBuf使うまでもないときに。
" nnoremap bb :b#<CR>
" nnoremap bp :bprevious<CR>
" nnoremap bn :bnext<CR>
" nnoremap bd :bdelete<CR>
"「最後に編集したテキスト」を選択するキーマップ。コピペ後などに重宝。「gv」と似て非なる使い勝手。
nnoremap gb `[v`]
" nnoremap gc `[v`]
" vnoremap gc :<C-u>normal gc<CR>
" onoremap gc :<C-u>normal gc<CR>
"表示中のバッファをVimスクリプトと見なして再読込。.vimrc変更後など。
"nnoremap <Space>r :<C-u>execute "source " expand("%:p")<CR>
"vimrcとgvimrcを再読込。vimrc変更後など。
"nnoremap <Space>v :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
".vimrc<e3><82><92>"nnoremap"で検索したときで、

" CTRL-hjklでウィンドウ移動
"nnoremap <C-j> :<C-w>j
"nnoremap <C-k> :<C-k>j
"nnoremap <C-l> :<C-l>j
"nnoremap <C-h> :<C-h>j

"""" http://code-life.net/?p=2704
"Quick Escaping
inoremap jj <Esc>

"どこでもVimrcの編集
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <silent> <Leader>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

"Vimrcの反映
"nnoremap <leader>sv :source $MYVIMRC<CR>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <Leader>sv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>sv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>sg :<C-u>source $MYGVIMRC<CR>

" Ctrl-s: Easier substitue
"vnoremap <C-s> :s/\%V//g<left><left><left>

""" http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
" 検索パターン入力中は/で\/を入力
" /そのものを入力するには<C-v>/とタイプ
"cnoremap <expr> /
"\ getcmdtype() == '/' ? '\/' : '/'
"
"cnoremap <expr> ?
"\ getcmdtype() == '/' ? '\/' : '/'

""" tjump
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

""" http://blog.soichiro.org/?p=66
" ヴィジュアルモードで選択したテキストをnで検索する(レジスタv使用)
vnoremap <silent> n "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
" gfでカーソル下のファイル名を新しいタブで開く
" nnoremap gF :tabedit <cfile><CR>
" vnoremap gF :tabedit <cfile><CR>
nnoremap gf :call DWM_Stack(1)<CR> :vertical topleft new <cfile><CR>
vnoremap gf :call DWM_Stack(1)<CR> :vertical topleft new <cfile><CR>
""" ~/.vim/bundle/dwm.vim/plugin/dwm.vim
" ヤンク、切り取り時にレジスタ"の値をzにもコピーしておく(連続貼付可に使う)
vnoremap <silent> y y:let @z=@"<CR>
vnoremap <silent> d d:let @z=@"<CR>
" ビジュアルモードで選択したテキストを消してレジスタzの内容を貼付ける(連続貼付可)
vnoremap <silent> p x"zP
" :makeや:grepをした際に自動的にquickfixが開くようにする
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd if len(getqflist()) != 0 | cw | endif
" ファイルを開いたときに前回の編集箇所に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


"---------------------------------------------------------------------------
" Key-mappings: "{{{
"

" Use <C-Space>.
map <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" Visual mode keymappings: "{{{
" <TAB>: indent.
xnoremap <TAB>  >
" <S-TAB>: unindent.
xnoremap <S-TAB>  <

" Indent
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
"}}}

" Insert mode keymappings: "{{{
" <C-t>: insert tab.
inoremap <C-t>  <C-v><TAB>
" <C-d>: delete char.
inoremap <C-d>  <Del>
" <C-a>: move to head.
inoremap <silent><C-a>  <C-o>^
" Enable undo <C-w> and <C-u>.
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>

if has('gui_running')
  inoremap <ESC> <ESC>
endif

" H, D: delete camlcasemotion.
inoremap <expr>H           <SID>camelcase_delete(0)
inoremap <expr>D           <SID>camelcase_delete(1)
function! s:camelcase_delete(is_reverse)
  let save_ve = &l:virtualedit
  setlocal virtualedit=all
  if a:is_reverse
    let cur_text = getline('.')[virtcol('.')-1 : ]
  else
    let cur_text = getline('.')[: virtcol('.')-2]
  endif
  let &l:virtualedit = save_ve

  let pattern = '\d\+\|\u\+\ze\%(\u\l\|\d\)\|' .
        \'\u\l\+\|\%(\a\|\d\)\+\ze_\|\%(\k\@!\S\)\+' .
        \'\|\%(_\@!\k\)\+\>\|[_]\|\s\+'

  if a:is_reverse
    let cur_cnt = len(matchstr(cur_text, '^\%('.pattern.'\)'))
  else
    let cur_cnt = len(matchstr(cur_text, '\%('.pattern.'\)$'))
  endif

  let del = a:is_reverse ? "\<Del>" : "\<BS>"

  return (pumvisible() ?
        \ neocomplcache#smart_close_popup() : '') . repeat(del, cur_cnt)
endfunction
"}}}

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*
"}}}

" Command line buffer."{{{
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap ;;  <SID>(command-line-enter)
xmap ;;  <SID>(command-line-enter)

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
autocmd MyAutoCmd CmdwinLeave * let g:neocomplcache_enable_auto_select = 1

function! s:init_cmdwin()
  NeoBundleSource vim-altercmd

  let g:neocomplcache_enable_auto_select = 0
  let b:neocomplcache_sources_list = ['vim_complete']

  nnoremap <buffer><silent> q :<C-u>quit<CR>
  nnoremap <buffer><silent> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> neocomplcache#close_popup()."\<CR>"
  inoremap <buffer><expr><C-h> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplcache#cancel_popup()."\<C-h>"
  inoremap <buffer><expr><BS> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplcache#cancel_popup()."\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ?
        \ "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>\<C-p>"

  startinsert!
endfunction"}}}

" [Space]: Other useful commands "{{{
" Smart space mapping.
" Notice: when starting other <Space> mappings in noremap, disappeared [Space].
nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>

" Toggle relativenumber.
nnoremap <silent> [Space].
      \ :<C-u>call ToggleOption('relativenumber')<CR>
nnoremap <silent> [Space]p
      \ :<C-u>call ToggleOption('paste')<CR>:set mouse=<CR>
" Toggle highlight.
nnoremap <silent> [Space]/
      \ :<C-u>call ToggleOption('hlsearch')<CR>
" Toggle cursorline.
nnoremap <silent> [Space]cl
      \ :<C-u>call ToggleOption('cursorline')<CR>
" Set autoread.
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>
" Output encoding information.
nnoremap <silent> [Space]en
      \ :<C-u>setlocal encoding? termencoding? fenc? fencs?<CR>
" Set spell check.
nnoremap [Space]sp
      \ :<C-u>call ToggleOption('spell')<CR>
nnoremap [Space]w
      \ :<C-u>call ToggleOption('wrap')<CR>
" Echo syntax name.
nnoremap [Space]sy
      \ :<C-u>echo synIDattr(synID(line('.'), col('.'), 1), "name")<CR>

" Easily edit .vimrc and .gvimrc "{{{
nnoremap <silent> [Space]ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]eg  :<C-u>edit $MYGVIMRC<CR>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> [Space]rv :<C-u>source $MYVIMRC \|
      \ if has('gui_running') \|
      \   source $MYGVIMRC \|
      \ endif \| echo "source $MYVIMRC"<CR>
nnoremap <silent> [Space]rg
      \ :<C-u>source $MYGVIMRC \|
      \ echo "source $MYGVIMRC"<CR>
"}}}

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

" Change current directory.
nnoremap <silent> [Space]cd :<C-u>call <SID>cd_buffer_dir()<CR>
function! s:cd_buffer_dir() "{{{
  let filetype = getbufvar(bufnr('%'), '&filetype')
  if filetype ==# 'vimfiler'
    let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
  elseif filetype ==# 'vimshell'
    let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
  else
    let dir = isdirectory(bufname('%')) ? bufname('%') : fnamemodify(bufname('%'), ':p:h')
  endif

  cd `=dir`
endfunction"}}}

" Delete windows ^M codes.
nnoremap <silent> [Space]<C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm

" Delete spaces before newline.
nnoremap <silent> [Space]ss mmHmt:<C-u>%s/<Space>$//ge<CR>`tzt`m

" Easily syntax change.
nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>

" Exchange gj and gk to j and k. "{{{
command! -nargs=? -bar -bang ToggleGJK call s:ToggleGJK()
nnoremap <silent> [Space]gj :<C-u>ToggleGJK<CR>
xnoremap <silent> [Space]gj :<C-u>ToggleGJK<CR>
function! s:ToggleGJK()
  if exists('b:enable_mapping_gjk') && b:enable_mapping_gjk
    let b:enable_mapping_gjk = 0
    noremap <buffer> j j
    noremap <buffer> k k
    noremap <buffer> gj gj
    noremap <buffer> gk gk

    xnoremap <buffer> j j
    xnoremap <buffer> k k
    xnoremap <buffer> gj gj
    xnoremap <buffer> gk gk
  else
    let b:enable_mapping_gjk = 1
    noremap <buffer> j gj
    noremap <buffer> k gk
    noremap <buffer> gj j
    noremap <buffer> gk k

    xnoremap <buffer> j gj
    xnoremap <buffer> k gk
    xnoremap <buffer> gj j
    xnoremap <buffer> gk k
  endif
endfunction"}}}

" Change tab width. "{{{
nnoremap <silent> [Space]t2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> [Space]t4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> [Space]t8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>
"}}}
"}}}

" s: Windows and buffers(High priority) "{{{
" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]
nnoremap <silent> [Window]p  :<C-u>call <SID>split_nicely()<CR>
nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
nnoremap <silent> [Window]c  :<C-u>call <sid>smart_close()<CR>
nnoremap <silent> -  :<C-u>call <SID>smart_close()<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :<C-u>Thumbnail<CR>

" A .vimrc snippet that allows you to move around windows beyond tabs
nnoremap <silent> <Tab> :call <SID>NextWindow()<CR>
nnoremap <silent> <S-Tab> :call <SID>PreviousWindowOrTab()<CR>

function! s:smart_close()
  if winnr('$') != 1
    close
  endif
endfunction

function! s:NextWindow()
  if winnr('$') == 1
    silent! normal! ``z.
  else
    wincmd w
  endif
endfunction

function! s:NextWindowOrTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    call s:split_nicely()
  elseif winnr() < winnr("$")
    wincmd w
  else
    tabnext
    1wincmd w
  endif
endfunction

function! s:PreviousWindowOrTab()
  if winnr() > 1
    wincmd W
  else
    tabprevious
    execute winnr("$") . "wincmd w"
  endif
endfunction

nnoremap <silent> [Window]<Space>  :<C-u>call <SID>ToggleSplit()<CR>
" If window isn't splited, split buffer.
function! s:ToggleSplit()
  let prev_name = winnr()
  silent! wincmd w
  if prev_name == winnr()
    SplitNicely
  else
    call s:smart_close()
  endif
endfunction
" Split nicely."{{{
command! SplitNicely call s:split_nicely()
function! s:split_nicely()
  " Split nicely.
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction
"}}}
" Delete current buffer."{{{
nnoremap <silent> [Window]d  :<C-u>call <SID>CustomBufferDelete(0)<CR>
" Force delete current buffer.
nnoremap <silent> [Window]D  :<C-u>call <SID>CustomBufferDelete(1)<CR>
function! s:CustomBufferDelete(is_force)
  let current = bufnr('%')

  call unite#util#alternate_buffer()

  if a:is_force
    silent! execute 'bdelete! ' . current
  else
    silent! execute 'bdelete ' . current
  endif
endfunction
"}}}

" JunkFile
" nnoremap <silent> [Window]e  :<C-u>JunkfileOpen<CR>
nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
command! -nargs=0 JunkfileDiary call junkfile#open_immediately(
      \ strftime('%Y-%m-%d.md'))
"}}}

" e: Change basic commands "{{{
" The prefix key.
nnoremap [Alt]   <Nop>
xnoremap [Alt]   <Nop>
nmap    e  [Alt]
xmap    e  [Alt]

nnoremap    [Alt]e   e
xnoremap    [Alt]e   e

" Indent paste.
nnoremap <silent> [Alt]p o<Esc>pm``[=`]``^
xnoremap <silent> [Alt]p o<Esc>pm``[=`]``^
nnoremap <silent> [Alt]P O<Esc>Pm``[=`]``^
xnoremap <silent> [Alt]P O<Esc>Pm``[=`]``^
" Insert blank line.
nnoremap <silent> [Alt]o o<Space><BS><ESC>
nnoremap <silent> [Alt]O O<Space><BS><ESC>
" Yank to end line.
nnoremap [Alt]y y$
nnoremap Y y$
nnoremap x "_x

" Useless commands
nnoremap [Alt];  ;
nnoremap [Alt],  ,
"}}}







"-------------------------------------------------
" Function ユーザー定義関数
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

" Paste Mode <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>


""" Alt key treats as meta key
""" http://blog.remora.cx/2012/07/using-alt-as-meta-in-vim.html
" let c = 'a'
" while c <= 'z'
"     execute "set <M-" . c . ">=\e" . c
"     execute "imap \e" . c . " <M-" . c . ">"
"     execute "set <M-S-" . c . ">=\e" . toupper(c)
"     execute "imap \e" . toupper(c) . " <M-" . c . ">"
"     let c = nr2char(1+char2nr(c))
" endw


""" http://vim-users.jp/2010/11/hack181/
" Open junk file."{{{
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction"}}}


""" http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html
" git-diff-aware version of gf commands.
"nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction




"-------------------------------------------------
" Plugin settings
"-------------------------------------------------

"""" https://powerline.readthedocs.org/en/latest/overview.html 
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"""" vim-powerline
let g:Powerline_symbols = 'fancy'
set t_Co=256

"""" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
"set background=light
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
call togglebg#map("<F5>")
"foldmethod=marker


" " * evervim {{{
" let g:evervim_devtoken='S=s1:U=f97c:E=14509054a1a:C=13db1541e1b:P=1cd:A=en-devtoken:V=2:H=4279c75fc904e7d3568c455c5f079c96'
" nnoremap <silent> ,el :<C-u>EvervimNotebookList<CR>
" nnoremap <silent> ,eT :<C-u>EvervimListTags<CR>
" nnoremap <silent> ,en :<C-u>EvervimCreateNote<CR>
" nnoremap <silent> ,eb :<C-u>EvervimOpenBrowser<CR>
" nnoremap <silent> ,ec :<C-u>EvervimOpenClient<CR>
" nnoremap ,es :<C-u>EvervimSearchByQuery<SPACE>
" nnoremap <silent> ,et :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done -tag:someday<CR>
" nnoremap <silent> ,eta :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done<CR>
" let g:evervim_splitoption=''
" " ------------------------ }}}


" html indentation
" https://github.com/pangloss/vim-javascript
" http://www.vim.org/scripts/script.php?script_id=2075
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" https://github.com/Lokaltog/vim-easymotion
let g:EasyMotion_leader_key = '<Leader>'

" https://bitbucket.org/ns9tks/vim-fuzzyfinder
"let g:fuf_keyOpen = '<Tab>'
"let g:fuf_keyOpenTabpage = '<CR>'
"nnoremap <silent> ,ff : <C-u>FufFile **/<CR>
"nnoremap <silent> ,fmf : <C-u>FufMruFile<CR>

" NEED Commenter
"let NERDShutUp = 1 "no alart undfined filetype
nnoremap <F7> :NERDTreeToggle<CR>


" rails.vim
let g:rails_level=3

" https://github.com/jelera/vim-javascript-syntax
"au FileType javascript call JavaScriptFold

" https://github.com/jiangmiao/simple-javascript-indenter
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" https://github.com/vim-scripts/jQuery
au BufRead,BufNewFile *.js,jquery.*.js set ft=javascript syntax=jquery



" https://github.com/Shougo/neocomplcache
" https://www.google.com/search?q=neocomplcache+site%3Avim-users.jp
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_plugin_completion_length = {
  \ 'buffer_complete'   : 2,
  \ 'include_complete'  : 2,
  \ 'syntax_complete'   : 2,
  \ 'filename_complete' : 2,
  \ 'keyword_complete'  : 2,
  \ 'omni_complete'     : 1
  \ }
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default'    : '',
  \ 'erlang'     : $HOME . '/.vim/dict/erlang.dict',
  \ 'objc'       : $HOME . '/.vim/dict/objc.dict',
  \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
  \ 'mxml'       : $HOME . '/.vim/dict/mxml.dict',
  \ 'ruby'       : $HOME . '/.vim/dict/ruby.dict',
  \ 'perl'       : $HOME . '/.vim/dict/perl.dict',
  \ 'scheme'     : $HOME . '/.vim/dict/gauche.dict',
  \ 'scala'      : $HOME . '/.vim/dict/scala.dict',
  \ 'int-erl'    : $HOME . '/.vim/dict/erlang.dict',
  \ 'int-irb'    : $HOME . '/.vim/dict/ruby.dict',
  \ 'int-perlsh' : $HOME . '/.vim/dict/perl.dict'
  \ }
let g:neocomplcache_same_filetype_lists = {
  \ 'c'          : 'ref-man,ref-erlang',
  \ 'perl'       : 'ref-perldoc',
  \ 'ruby'       : 'ref-refe',
  \ 'erlang'     : 'ref-erlang',
  \ 'objc'       : 'c',
  \ 'tt2html'    : 'html,perl',
  \ 'int-erl'    : 'erlang,ref-erlang',
  \ 'int-perlsh' : 'perl,ref-perldoc',
  \ 'int-irb'    : 'ruby,ref-refe'
  \ }

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_source_rank = {
  \ 'jscomplete' : 500,
  \ }

""" https://github.com/Shougo/neosnippet
" Plugin key-mappings.
imap <C-K>     <Plug>(neosnippet_expand_or_jump)
smap <C-K>     <Plug>(neosnippet_expand_or_jump)
xmap <C-K>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
""" https://gist.github.com/ujihisa/4024286
imap <expr> <Bslash> (pumvisible() && neosnippet#expandable() % 2 == 1) ?
      \ "\<Plug>(neosnippet_expand)" : '\'
imap <C-\> <Plug>(neosnippet_jump)
smap <C-\> <Plug>(neosnippet_jump)
nmap <C-\> a<C-\>

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets' + ',' + '~/.vim/bundle/vim-snippets/snippets'
" ~/.vim/bundle/neosnippet/autoload/neosnippet/snippets
" ~/.vim/bundle/vim-snippets/snippets
" ~/.vim/snippets

" neosnippet.vim
"{{{
""" https://github.com/Shougo/shougo-s-github/blob/master/vim/.vimrc
" let bundle = neobundle#get('neosnippet')
" function! bundle.hooks.on_source(bundle)
  " imap <silent>L     <Plug>(neosnippet_jump_or_expand)
  " smap <silent>L     <Plug>(neosnippet_jump_or_expand)
  " xmap <silent>L     <Plug>(neosnippet_start_unite_snippet_target)
  " imap <silent>K     <Plug>(neosnippet_expand_or_jump)
  " smap <silent>K     <Plug>(neosnippet_expand_or_jump)
  " imap <silent>G     <Plug>(neosnippet_expand)
  " imap <silent>S     <Plug>(neosnippet_start_unite_snippet)
  " xmap <silent>o     <Plug>(neosnippet_register_oneshot_snippet)
  " xmap <silent>U     <Plug>(neosnippet_expand_target)

  " let g:neosnippet#enable_snipmate_compatibility = 1

  " " let g:snippets_dir = '~/.vim/snippets/,~/.vim/bundle/snipmate/snippets/'
  " " let g:neosnippet#snippets_directory = '~/.vim/snippets'
" endfunction

" unlet bundle

" nnoremap <silent> [Window]f              :<C-u>Unite neosnippet/user neosnippet/runtime<CR>

"}}}


" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()



" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'





" https://github.com/teramako/jscomplete-vim
let g:jscomplete_use = ['dom', 'moz', 'es6th']



" https://github.com/scrooloose/syntastic
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': ['javascript'], 
  \ 'passive_filetypes': ['html']
  \}
let g:syntastic_auto_loc_list = 2
"let g:syntastic_javascript_checkers=['gjslint', 'jshint', 'jslint']
let g:syntastic_javascript_checkers=['jshint', 'jslint', 'gjslint']
let g:syntastic_javascript_gjslint_conf=' --nojsdoc'
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_php_php_args = '-l'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" https://github.com/majutsushi/tagbar
nnoremap <F8> :TagbarToggle<CR>

" https://github.com/majutsushi/tagbar
"let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'JavaScript',
    \ 'kinds'     : [
        \ 'c:class',
        \ 'p:property',
        \ 'm:method',
        \ 'o:object',
        \ 'f:function',
        \ 'a:array',
        \ 's:string',
        \ 'v:variable'
    \ ]
\ }

" https://github.com/mattn/zencoding-vim
"{{{
" " codaのデフォルトと一緒にする
" inoremap <C-E> <C-Y>,
" let g:user_zen_leader_key = '<C-Y>'
" " 言語別に対応させる
" let g:user_zen_settings = {
"       \  'lang' : 'ja',
"       \  'html' : {
"       \    'filters' : 'html',
"       \    'indentation' : ' '
"       \  },
"       \  'css' : {
"       \    'filters' : 'fc',
"       \  },
"       \}
"}}}


" https://github.com/tyru/open-browser.vim
" " カーソル下のURLをブラウザで開く
" nnoremap <Leader>o <Plug>(openbrowser-open)
" vnoremap <Leader>o <Plug>(openbrowser-open)
" " ググる
" nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>


" https://github.com/tell-k/vim-browsereload-mac
" let g:returnApp = "iTerm"
" nnoremap <Space>bc :ChromeReloadStart<CR>
" nnoremap <Space>bC :ChromeReloadStop<CR>
" nnoremap <Space>bf :FirefoxReloadStart<CR>
" nnoremap <Space>bF :FirefoxReloadStop<CR>
" nnoremap <Space>bs :SafariReloadStart<CR>
" nnoremap <Space>bS :SafariReloadStop<CR>
" nnoremap <Space>bo :OperaReloadStart<CR>
" nnoremap <Space>bO :OperaReloadStop<CR>
" nnoremap <Space>ba :AllBrowserReloadStart<CR>
" nnoremap <Space>bA :AllBrowserReloadStop<CR>


" https://github.com/AtsushiM/sass-compile.vim
"{{{
" let g:sass_compile_auto = 1
" let g:sass_compile_cdloop = 5
" let g:sass_compile_cssdir = ['css', 'stylesheet']
" let g:sass_compile_file = ['scss', 'sass']
" let g:sass_started_dirs = []
 
" autocmd FileType less,sass  setlocal sw=2 sts=2 ts=2 et
" au! BufWritePost * SassCompile
"}}}



" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

"""" http://qiita.com/items/fb442cfa78f91634cfaa
" taglistの設定 coffeeを追加
" let g:tlist_coffee_settings = 'coffee;f:function;v:variable'

"------------------------------------
" vim-coffee-script
"------------------------------------
" 保存時にコンパイル
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

"------------------------------------
" jasmine.vim
"------------------------------------
" ファイルタイプを変更
function! JasmineSetting()
  au BufRead,BufNewFile *Helper.js,*Spec.js  set filetype=jasmine.javascript
  au BufRead,BufNewFile *Helper.coffee,*Spec.coffee  set filetype=jasmine.coffee
  au BufRead,BufNewFile,BufReadPre *Helper.coffee,*Spec.coffee  let b:quickrun_config = {'type' : 'coffee'}
  "call jasmine#load_snippets()
  "map <buffer> <leader>m :JasmineRedGreen<CR>
  "command! JasmineRedGreen :call jasmine#redgreen()
  "command! JasmineMake :call jasmine#make()
endfunction
au BufRead,BufNewFile,BufReadPre *.coffee,*.js call JasmineSetting()

"------------------------------------
" indent_guides
"------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
" nmap <silent><Leader>ig <Plug>IndentGuidesToggle




" http://qiita.com/items/4398a19c05ad4861af85
au BufNewFile,BufRead Gemfile setl filetype=Gemfile
au BufWritePost Gemfile call vimproc#system('rbenv ctags')


" QuickRun
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config['coffee'] = {
     \'command' : 'coffee',
     \'exec' : ['%c -cbp %s']
     \}


"vim-ref
let g:ref_open = 'tabnew'
let g:ref_jquery_doc_path = $HOME . '/.vim/bundle/jqapi'
let g:ref_javascript_doc_path = $HOME . '/.vim/bundle/jsref/htdocs'
let g:ref_auto_resize = 1
let g:ref_wikipedia_lang = ['ja', 'en']
let g:ref_use_cache = 1



" https://github.com/mattn/gist-vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:github_user = 'h17u'


""" twitvim
" let twitvim_count = 40
" nnoremap ,tp :<C-u>PosttoTwitter<CR>
" nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
" nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
" nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
" nnoremap ,tn :<C-u>NextTwitter<CR>

" autocmd FileType twitvim call s:twitvim_my_settings()
" function! s:twitvim_my_settings()
"   set nowrap
" endfunction


""" https://github.com/terryma/vim-multiple-cursors
" let g:multi_cursor_use_default_mapping=0
" " Default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
" " Map start key separately from next key
" let g:multi_cursor_start_key='<F6>'

" let g:multi_cursor_exit_from_visual_mode=1
" let g:multi_cursor_exit_from_insert_mode=1
" " Default highlighting (see help :highlight and help :highlight-link)
" highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
" highlight link multiple_cursors_visual Visual


""" https://github.com/terryma/vim-expand-region
" Default settings.
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }
" Extend the global default
call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1,
      \ 'aB' :1,
      \ 'ii' :0,
      \ 'ai' :0,
      \ })
" Use the following setting for ruby.
let g:expand_region_text_objects_ruby = {
      \ 'im' :0,
      \ 'am' :0,
      \ }
" Use the global default + the following for ruby
call expand_region#custom_text_objects('ruby', {
      \ 'im' :0,
      \ 'am' :0,
      \ })
let g:expand_region_use_select_mode = 1


""" https://github.com/terryma/vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

""" https://github.com/osyo-manga/vim-anzu
" n や N の代わりに使用します。
nmap n <Plug>(anzu-n)zz
nmap N <Plug>(anzu-N)zz
nmap * <Plug>(anzu-star)zz
nmap # <Plug>(anzu-sharp)zz

" ステータス情報を statusline へと表示する
set statusline+=%{anzu#search_status()}

" こっちを使用すると
" 移動後にステータス情報をコマンドラインへと出力を行います。
" statusline を使用したくない場合はこっちを使用して下さい。
" nmap n <Plug>(anzu-n-with-echo)
" nmap N <Plug>(anzu-N-with-echo)
" nmap * <Plug>(anzu-star-with-echo)
" nmap # <Plug>(anzu-sharp-with-echo)

""" https://github.com/spolu/dwm.vim
""" ~/.vim/bundle/dwm.vim/plugin/dwm.vim
let g:dwm_map_keys = 1 " (1:default keybind)
" nmap <C-n> <Plug>DWMNew
" nmap <C-c> <Plug>DWMClose
" nmap <C-@> <Plug>DWMFocus
" nmap <C-Space> <Plug>DWMFocus
" nnoremap <C-j> <c-w>w
" nnoremap <C-k> <c-w>W
" nmap <C-,> <Plug>DWMRotateCounterclockwise
" nmap <C-.> <Plug>DWMRotateClockwise
" nmap <C-l> <Plug>DWMGrowMaster
" nmap <C-h> <Plug>DWMShrinkMaster

""" http://blog.remora.cx/2013/05/use-dwm-in-vim-2.html
" noremap zp :Unite buffer buffer_tab file_mru<CR>
" noremap zn :UniteWithBufferDir -buffer-name=files file file/new<CR>
" noremap zd :Unite dwm<CR>
"------------------------------------
" unite.vim
"------------------------------------
" noremap <C-Y><C-B> :Unite buffer dwm tab bookmark jump jump_point history/yank<CR>
" noremap <C-Y><C-F> :UniteWithBufferDir -buffer-name=files file file/new<CR>
" noremap <C-Y><C-R> :Unite file_mru<CR>
" noremap <C-Y><C-Y> :Unite -buffer-name=register register history/yank<CR>
" noremap <C-Y><C-U> :Unite buffer file_mru<CR>
" noremap <C-Y><C-M> :Unite -start-insert output:map<Bar>map!<Bar>lmap<CR>
" noremap <C-Y><C-S> :Unite snippets<CR>
" noremap <C-Y><C-H> :Unite help<CR>
" nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>
" noremap <C-Y><C-A> :UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" nnoremap <C-Y><C-O> :<C-u>Unite outline -vertical -winwidth=30 -no-quit<CR>
" vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
 

"""" unite-example
" The prefix key.
" nnoremap    [unite]   <Nop>
" nmap    f [unite]
nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap    ;u [unite]
xmap    ;u [unite]


nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
            \ -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
            \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
            \ -buffer-name=register register<CR>
" nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline -vertical -winwidth=30 -no-quit -resume<CR>
nnoremap <silent> [unite]f
            \ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]d
            \ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
" Key mappings
" nnoremap <silent> [unite]ma
"             \ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]ma :Unite -start-insert output:map<Bar>map!<Bar>lmap<CR>
nnoremap <silent> [unite]me
            \ :<C-u>Unite output:message<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>

nnoremap <silent> [unite]s
            \ :<C-u>Unite -buffer-name=files -no-split
            \ jump_point file_point buffer_tab
            \ file_rec:! file file/new file_mru<CR>
" Snippets
nnoremap <silent> [unite]s
            \ :<C-u>Unite snippets<CR>
" Help
nnoremap <silent> [unite]h
            \ :<C-u>Unite help<CR>
nnoremap <silent> [unite]k
            \ :<C-u>UniteWithCursorWord help<CR>
" grep by ag
vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>




""""
"""" ~/src/shougo-s-github/vim/.vimrc
""""
" nnoremap [unite]u  q:unite<space>
nnoremap <expr><silent> ;b  <sid>unite_build()
function! s:unite_build()
  return ":\<c-u>Unite -buffer-name=build". tabpagenr() ." -no-quit build\<cr>"
endfunction
nnoremap <silent> ;o
      \ :<c-u>Unite outline -start-insert -resume<cr>
nnoremap  [unite]f  :<c-u>unite source<cr>
nnoremap <silent> ;t
      \ :<c-u>UniteWithCursorWord -buffer-name=tag tag tag/include<cr>
xnoremap <silent> ;r
      \ d:<c-u>Unite -buffer-name=register register history/yank<cr>
nnoremap <silent> ;w
      \ :<c-u>UniteWithCursorWord -buffer-name=register
      \ buffer file_mru bookmark file<cr>
" nnoremap <silent> <c-k>
      " \ :<c-u>Unite change jump<cr>
nnoremap <silent> ;g
      \ :<c-u>Unite grep -buffer-name=search -auto-preview -no-quit -resume<cr>
nnoremap <silent> ;r
      \ :<c-u>Unite -buffer-name=register register history/yank<cr>
" inoremap <silent><expr> <c-z>
      " \ unite#start_complete('register', { 'input': unite#get_cur_text() })

" <C-t>: Tab pages
nnoremap <silent><expr> <C-t>
      \ ":\<C-u>Unite -select=".(tabpagenr()-1)." tab\<CR>"

" <C-w>: Windows operation
nnoremap <silent> <C-w>       :<C-u>Unite window<CR>

if s:is_windows
  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line
        \ jump_point file_point buffer_tab
        \ file_rec:! file file/new file_mru<CR>
else
  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line
        \ jump_point file_point buffer_tab
        \ file_rec/async:! file file/new file_mru<CR>
endif
nnoremap <silent> [Window]w
      \ :<C-u>Unite window<CR>
nnoremap <silent> [Space]b
      \ :<C-u>UniteBookmarkAdd<CR>

" t: tags-and-searches 
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Jump.
" nnoremap [Tag]t  <C-]>
nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "\<C-]>" :
      \ ":\<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include\<CR>"
nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
      \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor


" Execute help.
nnoremap <silent> <C-h>  :<C-u>Unite -buffer-name=help help<CR>

" Execute help by cursor keyword.
nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

" Search.
nnoremap <silent> /
      \ :<C-u>Unite -buffer-name=search -no-split -start-insert line<CR>
nnoremap <expr> g/  <SID>smart_search_expr('g/',
      \ ":\<C-u>Unite -buffer-name=search -auto-preview -start-insert line_migemo\<CR>")
nnoremap [Alt]/  g/
nnoremap <silent> ?
      \ :<C-u>Unite -buffer-name=search -auto-highlight -start-insert line:backward<CR>
nnoremap <silent> *
      \ :<C-u>UniteWithCursorWord -no-split -buffer-name=search line<CR>
nnoremap [Alt]/       /
nnoremap [Alt]?       ?
cnoremap <expr><silent><C-g>        (getcmdtype() == '/') ?
      \ "\<ESC>:Unite -buffer-name=search -no-split line -input=".getcmdline()."\<CR>" : "\<C-g>"

function! s:smart_search_expr(expr1, expr2)
  return line('$') > 5000 ?  a:expr1 : a:expr2
endfunction

nnoremap <silent> n
      \ :<C-u>UniteResume search -no-start-insert<CR>

let g:unite_source_history_yank_enable = 1

" For unite-alias.
let g:unite_source_alias_aliases = {}
let g:unite_source_alias_aliases.test = {
      \ 'source' : 'file_rec',
      \ 'args'   : '~/',
      \ }
let g:unite_source_alias_aliases.line_migemo = {
      \ 'source' : 'line',
      \ }
let g:unite_source_alias_aliases.message = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.mes = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.scriptnames = {
      \ 'source' : 'output',
      \ 'args'   : 'scriptnames',
      \ }

" For unite-menu.
let g:unite_source_menu_menus = {}

let g:unite_source_menu_menus.enc = {
      \     'description' : 'Open with a specific character code again.',
      \ }
let g:unite_source_menu_menus.enc.command_candidates = [
      \       ['utf8', 'Utf8'],
      \       ['iso2022jp', 'Iso2022jp'],
      \       ['cp932', 'Cp932'],
      \       ['euc', 'Euc'],
      \       ['utf16', 'Utf16'],
      \       ['utf16-be', 'Utf16be'],
      \       ['jis', 'Jis'],
      \       ['sjis', 'Sjis'],
      \       ['unicode', 'Unicode'],
      \     ]
nnoremap <silent> ;e :<C-u>Unite menu:enc<CR>

let g:unite_source_menu_menus.fenc = {
      \     'description' : 'Change file fenc option.',
      \ }
let g:unite_source_menu_menus.fenc.command_candidates = [
      \       ['utf8', 'WUtf8'],
      \       ['iso2022jp', 'WIso2022jp'],
      \       ['cp932', 'WCp932'],
      \       ['euc', 'WEuc'],
      \       ['utf16', 'WUtf16'],
      \       ['utf16-be', 'WUtf16be'],
      \       ['jis', 'WJis'],
      \       ['sjis', 'WSjis'],
      \       ['unicode', 'WUnicode'],
      \     ]
nnoremap <silent> ;f :<C-u>Unite menu:fenc<CR>

let g:unite_source_menu_menus.ff = {
      \     'description' : 'Change file format option.',
      \ }
let g:unite_source_menu_menus.ff.command_candidates = {
      \       'unix'   : 'WUnix',
      \       'dos'    : 'WDos',
      \       'mac'    : 'WMac',
      \     }
nnoremap <silent> ;w :<C-u>Unite menu:ff<CR>

let g:unite_source_menu_menus.unite = {
      \     'description' : 'Start unite sources',
      \ }
let g:unite_source_menu_menus.unite.command_candidates = {
      \       'history'    : 'Unite history/command',
      \       'quickfix'   : 'Unite qflist -no-quit',
      \       'resume'     : 'Unite -buffer-name=resume resume',
      \       'directory'  : 'Unite -buffer-name=files '.
      \             '-default-action=lcd directory_mru',
      \       'mapping'    : 'Unite mapping',
      \       'message'    : 'Unite output:message',
      \       'scriptnames': 'Unite output:scriptnames',
      \     }
" nnoremap <silent> ;u :<C-u>Unite menu:unite -resume<CR>
nnoremap <silent> [unite]u :<C-u>Unite menu:unite<CR>

let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
  autocmd MyAutoCmd FileType unite call s:unite_my_settings()

  call unite#set_profile('action', 'context', {'start_insert' : 1})

  " Set "-no-quit" automatically in grep unite source.
  call unite#set_profile('source/grep', 'context', {'no_quit' : 1})

  " migemo.
  call unite#custom_source('line_migemo', 'matchers', 'matcher_migemo')

  call unite#custom_source('file_rec', 'sorters', 'sorter_reverse')

  " Custom filters.
  call unite#custom_source(
        \ 'buffer,file_rec/async,file_mru', 'matchers',
        \ ['converter_tail', 'matcher_fuzzy'])
  call unite#custom_source(
        \ 'file_rec', 'matchers', ['matcher_fuzzy'])
  call unite#custom_source(
        \ 'file_rec/async,file_mru', 'converters',
        \ ['converter_file_directory'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  

  function! s:unite_my_settings() 
    " Directory partial match.
    call unite#set_substitute_pattern('files', '^\.v/',
          \ [expand('~/.vim/'), unite#util#substitute_path_separator($HOME)
          \ . '/.bundle/*/'], 1000)
    call unite#custom_alias('file', 'h', 'left')
    call unite#custom_default_action('directory', 'narrow')
    " call unite#custom_default_action('file', 'my_tabopen')

    call unite#custom_default_action('versions/git/status', 'commit')

    " call unite#custom_default_action('directory', 'cd')

    " Custom actions.
    let my_tabopen = {
          \ 'description' : 'my tabopen items',
          \ 'is_selectable' : 1,
          \ }
    function! my_tabopen.func(candidates) 
      call unite#take_action('tabopen', a:candidates)

      let dir = isdirectory(a:candidates[0].word) ?
            \ a:candidates[0].word : fnamemodify(a:candidates[0].word, ':p:h')
      execute g:unite_kind_openable_lcd_command '`=dir`'
    endfunction
    call unite#custom_action('file,buffer', 'tabopen', my_tabopen)
    unlet my_tabopen
    

    " Overwrite settings.
    imap <buffer>  <BS>      <Plug>(unite_delete_backward_path)
    imap <buffer>  jj      <Plug>(unite_insert_leave)
    imap <buffer><expr> j unite#smart_map('j', '')
    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
    imap <buffer> '     <Plug>(unite_quick_match_default_action)
    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> x
          \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
    nmap <buffer> cd     <Plug>(unite_quick_match_default_action)
    nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    " nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    " imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    nmap <silent><buffer> <Tab>     :call <SID>NextWindow()<CR>
    nnoremap <silent><buffer><expr> l
          \ unite#smart_map('l', unite#do_action('default'))
    nmap <buffer> <C-e>     <Plug>(unite_narrowing_input_history)

    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
          \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
  endfunction

  " Variables.
  let g:unite_enable_split_vertically = 0
  let g:unite_winheight = 20
  let g:unite_enable_start_insert = 0
  let g:unite_enable_short_source_names = 1

  let g:unite_cursor_line_highlight = 'TabLineSel'
  " let g:unite_abbr_highlight = 'TabLine'
  " let g:unite_source_file_mru_time_format = ''
  let g:unite_source_file_mru_filename_format = ':~:.'
  let g:unite_source_file_mru_limit = 300
  " let g:unite_source_directory_mru_time_format = ''
  let g:unite_source_directory_mru_limit = 300

  if s:is_windows
  else
    " Like Textmate icons.
    let g:unite_marked_icon = '✗'

    " Prompt choices.
    "let g:unite_prompt = '❫ '
    let g:unite_prompt = '» '
  endif

  if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('jvgrep')
    " For jvgrep.
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '--exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
  elseif executable('ack-grep')
    " For ack.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
    let g:unite_source_grep_recursive_opt = ''
  endif

  " let g:unite_build_error_icon    = $DOTVIM . '/signs/err.'
        " \ . (s:is_windows ? 'bmp' : 'png')
  " let g:unite_build_warning_icon  = $DOTVIM . '/signs/warn.'
        " \ . (s:is_windows ? 'bmp' : 'png')
endfunction

unlet bundle


" s: Windows and buffers(High priority) 
" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]
nnoremap <silent> [Window]p  :<C-u>call <SID>split_nicely()<CR>
nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
nnoremap <silent> [Window]c  :<C-u>call <sid>smart_close()<CR>
nnoremap <silent> -  :<C-u>call <SID>smart_close()<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :<C-u>Thumbnail<CR>



""" http://blog.remora.cx/2012/09/use-tabpage.html
""" keybind for tab
" nnoremap <S-Tab> gt
" nnoremap <Tab><Tab> gT
" for i in range(1, 9)
"     execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
" endfor

""" https://github.com/Shougo/vimfiler.vim
let g:vimfiler_as_default_explorer = 1
nnoremap <F6> :VimFilerExplorer<CR>


""" https://github.com/fuenor/qfixgrep.git
" let g:memolist_qfixgrep = 1
" map <Leader>ml  :MemoList<CR>
" map <Leader>mn  :MemoNew<CR>
" map <Leader>mg  :MemoGrep<CR>

""" https://github.com/kien/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }

""" https://github.com/scrooloose/nerdcommenter
let NERDSpaceDelims = 1
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle



"-------------------------------------------------
" Filetype ユーザー定義関数
"-------------------------------------------------
set foldenable
" set foldmethod=indent
" set foldnestmax=2
" set foldminlines=10
" set fillchars=fold:\ ,vert:\|

" " if you want enable syntax fold, use au FileType .. set foldmethod=syntax
" set foldmethod=syntax
" set foldlevelstart=1

" let javaScript_fold=1         " JavaScript
" let perl_fold=1               " Perl
" let php_folding=1             " PHP
" let r_syntax_folding=1        " R
" let ruby_fold=1               " Ruby
" let sh_fold_enabled=1         " sh
" let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" as3
autocmd FileType actionscript set omnifunc=actionscriptcomplete#CompleteAS
autocmd FileType actionscript set dictionary+=$HOME/.vim/dict/actionscript.dict

" javascript
au FileType javascript,coffee set dictionary+=$HOME/.vim/dict/javascript.dict
au FileType javascript,coffee set dictionary+=$HOME/.vim/dict/node.dict
au FileType javascript,coffee set dictionary+=$HOME/.vim/dict/jQuery.dict

" autocmd FileType javascript,less,c,ruby,eruby,perl,tex,sass,scss,coffee,html,xhtml :setlocal tabstop=2 shiftwidth=2 softtabstop=2 shiftwidth=2
autocmd FileType actionscript setlocal noexpandtab

au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile *.json set ft=javascript

" jade
autocmd FileType jade set commentstring=//-\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType nginx set commentstring=#\ %s

" C/C++
au FileType c,cpp set path+=/usr/local/include/**

" ctags
:autocmd BufWritePost *.js call system('ctags -R')


"""" http://labs.timedia.co.jp/2011/04/javascript-function-lambda-vim.html
setlocal conceallevel=2
syntax keyword javaScriptLambda function conceal cchar=λ
highlight clear Conceal
highlight link Conceal Identifier
highlight link javaScriptLambda Identifier



"""" TODO
" <Leader> key is not effective?
" commenter gc conflict to gc, gv

"""" Cheet
" gg=G
"
" http://labs.timedia.co.jp/2012/01/vim-textobj-line.html
" 改行コードを除いて、カーソル行を選択/処理
" ^vg_"*y と同じことが vil"*y や "*yil
" 0v$h"*y と同じことが val"*y や "*yal

""" grep
" :Grep -r -i pattern filepath
" :!grep [option] pattern filepath
" **/*.vim

""" jvgrep
"  jvgrep 表[現示] **/*.txt
"  :grep 表[現示] **/*.txt


" TODO
" folding


" vim: foldmethod=marker
