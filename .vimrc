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
NeoBundle 'migemo', {'type' : 'nosync', 'base' : '~/.vim/bundle/manual'}
NeoBundleLazy 'git://github.com/kakkyz81/evervim.git', {'command' : [ 'EvervimCreateNote', 'EvervimNotebookList', 'EvervimListTags', 'EvervimSearchByQuery' ] }
"NeoBundleLazy 'git://github.com/tpope/vim-rails.git', {'autoload': {'filetypes': ['ruby']}}
NeoBundleLazy 'git://github.com/tpope/vim-rails.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
"NeoBundleLazy 'git://github.com/tpope/vim-fugitive.git', {'command' : [ 'Gstatus' ] }
NeoBundle 'https://github.com/scrooloose/nerdtree'
NeoBundle 'https://github.com/scrooloose/nerdcommenter'
NeoBundle 'https://github.com/Lokaltog/vim-easymotion'
NeoBundle 'https://bitbucket.org/ns9tks/vim-l9'
NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'
NeoBundle 'https://github.com/kana/vim-fakeclip'
NeoBundle 'https://github.com/vim-scripts/mru.vim'
NeoBundle 'https://github.com/Townk/vim-autoclose'
NeoBundle 'https://github.com/vim-ruby/vim-ruby'
"NeoBundle 'https://github.com/msanders/snipmate.vim'
NeoBundle 'https://github.com/pangloss/vim-javascript'
NeoBundle 'https://github.com/jelera/vim-javascript-syntax'
NeoBundle 'https://github.com/jiangmiao/simple-javascript-indenter'
NeoBundle 'https://github.com/vim-scripts/jQuery'
NeoBundle 'https://github.com/teramako/jscomplete-vim'
NeoBundle 'https://github.com/Shougo/neosnippet'
"NeoBundle 'https://github.com/honza/snipmate-snippets'
NeoBundle 'https://github.com/majutsushi/tagbar'
NeoBundle 'https://github.com/mattn/zencoding-vim'
NeoBundle 'https://github.com/tyru/open-browser.vim'
NeoBundle 'https://github.com/tyru/open-browser-github.vim'
NeoBundle 'https://github.com/tell-k/vim-browsereload-mac'
NeoBundle 'https://github.com/vim-jp/vimdoc-ja'
NeoBundle 'https://github.com/hail2u/vim-css3-syntax'
NeoBundle 'https://github.com/AtsushiM/sass-compile.vim'
NeoBundle 'https://github.com/kchmck/vim-coffee-script'
NeoBundle 'https://github.com/claco/jasmine.vim'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides'



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
let $LANG='C'
set helplang=ja,en


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
"set sm             " show matching braces, somewhat annoying...
set showmatch       " show matching braces, somewhat annoying...
set matchtime=5
set wildmenu        " コマンドライン補完するときに補完候補を表示する
set wildmode=longest:full,list
set nowrap         " don't wrap lines
"set list	" タブ文字、行末など不可視文字を表示する  
"set listchars=eol:$,tab:>\ ,extends:<	" listで表示される文字のフォーマットを指定する
set clipboard=unnamed "share clipboard on Mac GUI app
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く



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






"-------------------------------------------------
" Mappings キーマッピング
"-------------------------------------------------
 
"-------------------------------------------------
" Move 移動設定
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
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
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
 
"Vimrcの反映
"nnoremap <leader>rv :source $MYVIMRC<CR>



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

""""http://vim.sourceforge.net/scripts/script.php?script_id=2204
"let twitvim_login = "tommy_io:password"
"let twitvim_login_b64 = "dG9tbXlfaW86bWkwazdhbW95bWlndTVNZQ=="
"let twitvim_count = 50 

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
let g:fuf_keyOpen = '<Tab>'
let g:fuf_keyOpenTabpage = '<CR>'
nnoremap <silent> ,ff : <C-u>FufFile **/<CR>
nnoremap <silent> ,fmf : <C-u>FufMruFile<CR>

" NEED Commenter
let NERDShutUp = 1 "no alart undfined filetype

" rails.vim
let g:rails_level=3

" https://github.com/jelera/vim-javascript-syntax
au FileType javascript call JavaScriptFold

" https://github.com/jiangmiao/simple-javascript-indenter
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
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
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript,coffee setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'





" https://github.com/teramako/jscomplete-vim
:let g:jscomplete_use = ['dom', 'moz']



" https://github.com/scrooloose/syntastic
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [], 
  \ 'passive_filetypes': ['html', 'javascript'] }
let g:syntastic_auto_loc_list = 1 
let g:syntastic_javascript_checker=['gjslint', 'jshint', 'jslint']
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']



" https://github.com/majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

" https://github.com/majutsushi/tagbar
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/local/bin/jsctags'
    \ }

" https://github.com/mattn/zencoding-vim
"{{{
" codaのデフォルトと一緒にする
imap <C-E> <C-Y>,
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
" カーソル下のURLをブラウザで開く
nnoremap <Leader>o <Plug>(openbrowser-open)
vnoremap <Leader>o <Plug>(openbrowser-open)
" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>


" https://github.com/tell-k/vim-browsereload-mac
let g:returnApp = "iTerm"
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
nmap <Space>bf :FirefoxReloadStart<CR>
nmap <Space>bF :FirefoxReloadStop<CR>
nmap <Space>bs :SafariReloadStart<CR>
nmap <Space>bS :SafariReloadStop<CR>
nmap <Space>bo :OperaReloadStart<CR>
nmap <Space>bO :OperaReloadStop<CR>
nmap <Space>ba :AllBrowserReloadStart<CR>
nmap <Space>bA :AllBrowserReloadStop<CR>


" https://github.com/AtsushiM/sass-compile.vim
"{{{
let g:sass_compile_auto = 1
let g:sass_compile_cdloop = 5
let g:sass_compile_cssdir = ['css', 'stylesheet']
let g:sass_compile_file = ['scss', 'sass']
let g:sass_started_dirs = []
 
autocmd FileType less,sass  setlocal sw=2 sts=2 ts=2 et
au! BufWritePost * SassCompile
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


