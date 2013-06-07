" pathogen.vim: manage your runtimepath
"https://github.com/tpope/vim-pathogen
"call pathogen#runtimel_append_all_bundles()

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
NeoBundle 'https://github.com/Shougo/vimproc'

"" My Bundles here:
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/Lokaltog/powerline.git' "Need Python interpriter
"NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
"NeoBundle 'migemo', {'type' : 'nosync', 'base' : '~/.vim/bundle/manual'}
"NeoBundleLazy 'git://github.com/kakkyz81/evervim.git', {'command' : [ 'EvervimCreateNote', 'EvervimNotebookList', 'EvervimListTags', 'EvervimSearchByQuery' ] }
"NeoBundleLazy 'git://github.com/tpope/vim-rails.git'
"NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/scrooloose/nerdtree'
"NeoBundle 'https://github.com/scrooloose/nerdcommenter'
"NeoBundle 'https://github.com/Lokaltog/vim-easymotion'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-l9'
"NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'
"NeoBundle 'https://github.com/kana/vim-fakeclip'
"NeoBundle 'https://github.com/vim-scripts/mru.vim'
NeoBundle 'https://github.com/Townk/vim-autoclose'
NeoBundle 'https://github.com/vim-ruby/vim-ruby'
"NeoBundle 'https://github.com/msanders/snipmate.vim'
"NeoBundle 'https://github.com/pangloss/vim-javascript'
"NeoBundle 'https://github.com/jelera/vim-javascript-syntax'
NeoBundle 'https://github.com/jiangmiao/simple-javascript-indenter'
NeoBundle 'https://github.com/vim-scripts/jQuery'
NeoBundle 'https://github.com/teramako/jscomplete-vim'
NeoBundle 'https://github.com/Shougo/neosnippet'
"NeoBundle 'https://github.com/honza/snipmate-snippets'
NeoBundle 'https://github.com/majutsushi/tagbar'
NeoBundle 'https://github.com/mattn/zencoding-vim'
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
"NeoBundle 'https://github.com/msanders/cocoa.vim'
NeoBundle 'https://github.com/terryma/vim-multiple-cursors'
NeoBundle 'https://github.com/terryma/vim-expand-region'
NeoBundle 'https://github.com/terryma/vim-smooth-scroll'
"NeoBundle 'https://github.com/kana/vim-textobj-line'
"NeoBundle 'https://github.com/kana/vim-textobj-entire'
NeoBundle 'https://github.com/osyo-manga/vim-anzu'
NeoBundle 'https://github.com/spolu/dwm.vim'
NeoBundle 'https://github.com/kannokanno/unite-dwm'
NeoBundle 'https://github.com/Shougo/vimfiler.vim'
NeoBundle 'https://github.com/tpope/vim-surround'
"NeoBundle 'https://github.com/tpope/vim-speeddating'
"NeoBundle 'https://github.com/tpope/vim-abolish'
"NeoBundle 'https://github.com/tpope/vim-unimpaired'
NeoBundle 'https://github.com/tpope/vim-commentary'
NeoBundle 'https://github.com/tpope/vim-repeat'
NeoBundle 'https://github.com/fuenor/qfixgrep.git'
NeoBundle 'https://github.com/glidenote/memolist.vim'
NeoBundle 'https://github.com/tsukkee/unite-tag'



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

"set statusline=%F%M%R%=code:%B%H%W "{フルパス},+,RO code:{文字コード},HLP,PRV

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

set conceallevel=0
highlight link HelpBar Normal
highlight link HelpStar Normal

set helpheight=30
set tags=tags

" ステータスラインの表示
" http://blog.ruedap.com/entry/20110712/vim_statusline_git_branch_name
  " set statusline=%<     " 行が長すぎるときに切り詰める位置
  " set statusline+=[%n]  " バッファ番号
  " set statusline+=%m    " %m 修正フラグ
  " set statusline+=%r    " %r 読み込み専用フラグ
  " set statusline+=%h    " %h ヘルプバッファフラグ
  " set statusline+=%w    " %w プレビューウィンドウフラグ
  " set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
  " set statusline+=%y    " バッファ内のファイルのタイプ
  " set statusline+=\     " 空白スペース
" if winwidth(0) >= 130
  " set statusline+=%F    " バッファ内のファイルのフルパス
" else
  " set statusline+=%t    " ファイル名のみ
" endif
  " set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  " set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  " set statusline+=\ \   " 空白スペース2個
  " set statusline+=%1l   " 何行目にカーソルがあるか
  " set statusline+=/
  " set statusline+=%L    " バッファ内の総行数
  " set statusline+=,
  " set statusline+=%c    " 何列目にカーソルがあるか
  " set statusline+=%V    " 画面上の何列目にカーソルがあるか
  " set statusline+=\ \   " 空白スペース2個
  " set statusline+=%P    " ファイル内の何％の位置にあるか

"-------------------------------------------------
" Mappings キーマッピング
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
nnoremap bb :b#<CR>
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
nnoremap bd :bdelete<CR>
"「最後に編集したテキスト」を選択するキーマップ。コピペ後などに重宝。「gv」と似て非なる使い勝手。
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>
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
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

"Vimrcの反映
"nnoremap <leader>sv :source $MYVIMRC<CR>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

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




"-------------------------------------------------
" Plugin settings
"-------------------------------------------------

"""" https://powerline.readthedocs.org/en/latest/overview.html 
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

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


" * evervim {{{
let g:evervim_devtoken='S=s1:U=f97c:E=14509054a1a:C=13db1541e1b:P=1cd:A=en-devtoken:V=2:H=4279c75fc904e7d3568c455c5f079c96'
nnoremap <silent> ,el :<C-u>EvervimNotebookList<CR>
nnoremap <silent> ,eT :<C-u>EvervimListTags<CR>
nnoremap <silent> ,en :<C-u>EvervimCreateNote<CR>
nnoremap <silent> ,eb :<C-u>EvervimOpenBrowser<CR>
nnoremap <silent> ,ec :<C-u>EvervimOpenClient<CR>
nnoremap ,es :<C-u>EvervimSearchByQuery<SPACE>
nnoremap <silent> ,et :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done -tag:someday<CR>
nnoremap <silent> ,eta :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done<CR>
let g:evervim_splitoption=''
" ------------------------ }}}


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
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 3
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
let g:neocomplcache_snippets_dir = $HOME . '/.vim/snippets'


if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_source_rank = {
  \ 'jscomplete' : 500,
  \ }

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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
let g:syntastic_check_on_open = 1
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
" codaのデフォルトと一緒にする
inoremap <C-E> <C-Y>,
let g:user_zen_leader_key = '<C-Y>'
" 言語別に対応させる
let g:user_zen_settings = {
      \  'lang' : 'ja',
      \  'html' : {
      \    'filters' : 'html',
      \    'indentation' : ' '
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \  },
      \}
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
nmap <silent><Leader>ig <Plug>IndentGuidesToggle




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
let twitvim_count = 40
nnoremap ,tp :<C-u>PosttoTwitter<CR>
nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
nnoremap ,tn :<C-u>NextTwitter<CR>

autocmd FileType twitvim call s:twitvim_my_settings()
function! s:twitvim_my_settings()
  set nowrap
endfunction


""" https://github.com/terryma/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
"let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<Esc>'
" Map start key separately from next key
"let g:multi_cursor_start_key='<F6>'

let g:multi_cursor_exit_from_visual_mode=1
let g:multi_cursor_exit_from_insert_mode=1
" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual


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
"nmap n <Plug>(anzu-n)
"nmap N <Plug>(anzu-N)
"nmap * <Plug>(anzu-star)
"nmap # <Plug>(anzu-sharp)

" ステータス情報を statusline へと表示する
"set statusline=%{anzu#search_status()}

" こっちを使用すると
" 移動後にステータス情報をコマンドラインへと出力を行います。
" statusline を使用したくない場合はこっちを使用して下さい。
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

""" https://github.com/spolu/dwm.vim
" dwm.vim 設定（全てデフォルト）
nnoremap <c-j> <c-w>w
nnoremap <c-k> <c-w>W
nmap <m-r> <Plug>DWMRotateCounterclockwise
nmap <m-t> <Plug>DWMRotateClockwise
nmap <c-n> <Plug>DWMNew
nmap <c-c> <Plug>DWMClose
nmap <c-@> <Plug>DWMFocus
nmap <c-Space> <Plug>DWMFocus
nmap <c-l> <Plug>DWMGrowMaster
nmap <c-h> <Plug>DWMShrinkMaster

""" http://blog.remora.cx/2013/05/use-dwm-in-vim-2.html
noremap zp :Unite buffer_tab file_mru<CR>
noremap zn :UniteWithBufferDir -buffer-name=files file file/new<CR>
noremap zd :Unite dwm<CR>
 
autocmd FileType unite call s:unite_my_settings()
 
function! s:unite_my_settings()
    " 上下に分割して開く
    nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    " 左右に分割して開く
    nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    " タブで開く
    nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
    inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
    " vimfiler で開く
    nnoremap <silent> <buffer> <expr> <C-O> unite#do_action('vimfiler')
    inoremap <silent> <buffer> <expr> <C-O> unite#do_action('vimfiler')
    " dwm.vim で開く
    nnoremap <silent> <buffer> <expr> <C-N> unite#do_action('dwm_new')
    inoremap <silent> <buffer> <expr> <C-N> unite#do_action('dwm_new')
    " 終了
    nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
endfunction
 
" http://blog.remora.cx/2012/09/use-tabpage.html
" keybind for tab
nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

""" https://github.com/Shougo/vimfiler.vim
let g:vimfiler_as_default_explorer = 1
nnoremap <F6> :VimFilerExplorer<CR>


""" https://github.com/fuenor/qfixgrep.git
let g:memolist_qfixgrep = 1
map <Leader>ml  :MemoList<CR>
map <Leader>mn  :MemoNew<CR>
map <Leader>mg  :MemoGrep<CR>


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
