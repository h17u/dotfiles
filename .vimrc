"---------------------------------------------------------------------------
" .vimrc
"---------------------------------------------------------------------------
" Initialize:"{{{
"

" Before neobundle#rc "{{{
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

if has('vim_starting') "{{{
  " Set runtimepath.
  if s:is_windows
    let &runtimepath = join([
          \ expand('~/.vim'),
          \ expand('$VIM/runtime'),
          \ expand('~/.vim/after')], ',')
  endif

  " Load neobundle.
  if isdirectory('neobundle.vim')
    set runtimepath+=neobundle.vim
  elseif finddir('neobundle.vim', '.;') != ''
    execute 'set runtimepath+=' . finddir('neobundle.vim', '.;')
  elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_dir.'/neobundle.vim')
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir.'/neobundle.vim'
    endif

    execute 'set runtimepath+=' . s:neobundle_dir.'/neobundle.vim'
  endif

  if filereadable('vimrc_local.vim') ||
        \ findfile('vimrc_local.vim', '.;') != ''
    " Load develop version.
    call neobundle#local(fnamemodify(
          \ findfile('vimrc_local.vim', '.;'), ':h'), { 'resettable' : 0 })
  endif

  "set vimball home directory
  let g:vimball_home = $HOME . '/.vim'
endif
"}}}

let g:neobundle#enable_tail_path = 1
let g:neobundle#default_options = {
      \ 'default' : { 'overwrite' : 0 },
      \ }

call neobundle#rc(s:neobundle_dir)
"}}}

" neobundle.vim"{{{
NeoBundleFetch 'Shougo/neobundle.vim', '', 'default'

" NeoBundle 'tpope/vim-surround', {
NeoBundle 'anyakichi/vim-surround', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['n', '<Plug>Dsurround'], ['n', '<Plug>Csurround'],
      \     ['n', '<Plug>Ysurround'], ['n', '<Plug>YSurround']
      \ ]}}
NeoBundleLazy 'basyura/TweetVim', { 'depends' :
      \ [ 'basyura/twibill.vim',
      \ 'tyru/open-browser.vim',
      \ 'basyura/bitly.vim',
      \ 'mattn/webapi-vim' ],
      \ 'autoload' : { 'commands' : 'TweetVimHomeTimeline' }}

" NeoBundleLazy 'c9s/perlomni.vim'
" NeoBundleLazy 'choplin/unite-vim_hacks'
" NeoBundleLazy 'liquidz/vimfiler-sendto'

NeoBundle 'Shougo/neocomplete.vim', '', 'default'
NeoBundle 'Shougo/context_filetype.vim', '', 'default'

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

NeoBundle 'Shougo/neobundle-vim-scripts', '', 'default'

NeoBundle 'Shougo/unite.vim', '', 'default'
call neobundle#config('unite.vim',{
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'Unite',
      \                   'complete' : 'customlist,unite#complete_source'},
      \                 'UniteWithCursorWord', 'UniteWithInput']
      \ }})
NeoBundle 'Shougo/unite-build', '', 'default'
NeoBundle 'Shougo/unite-ssh', '', 'default'
NeoBundle 'Shougo/unite-sudo', '', 'default'
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
NeoBundle 'Shougo/vimproc', '', 'default'
call neobundle#config('vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ })

NeoBundle 'Shougo/vinarise', '', 'default'
call neobundle#config('vinarise', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : 'Vinarise',
      \ }})

NeoBundle 'Shougo/vesting', '', 'default'
NeoBundle 'vim-jp/vital.vim', '', 'default'
call neobundle#config('vital.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \     'commands' : ['Vitalize'],
      \ }})
NeoBundle 'Shougo/junkfile.vim', '', 'default'
call neobundle#config('junkfile.vim', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : 'JunkfileOpen',
      \   'unite_sources' : ['junkfile', 'junkfile/new'],
      \ }})

" NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/unite-outline', '', 'default'
call neobundle#config('unite-outline', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'outline'},
      \ })

NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : 'css'
      \ }}
NeoBundleLazy 'kana/vim-smartchr', { 'autoload' : {
      \ 'insert' : 1,
      \ }}
NeoBundleLazy 'kana/vim-smartword', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smartword-w)', '<Plug>(smartword-b)', '<Plug>(smartword-ge)']
      \ }}
NeoBundleLazy 'kana/vim-smarttill', { 'autoload' : {
      \ 'mappings' : [
      \   '<Plug>(smarttill-t)', '<Plug>(smarttill-T)']
      \ }}
NeoBundleLazy 'kana/vim-operator-user'
NeoBundleLazy 'kana/vim-operator-replace', {
      \ 'depends' : 'vim-operator-user',
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>(operator-replace)']]
      \ }}
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'LeafCage/foldCC'
NeoBundleLazy 'mattn/wwwrenderer-vim'
NeoBundleLazy 'mattn/webapi-vim'
" NeoBundle 'basyura/webapi-vim'
NeoBundleLazy 'add20/vim-conque', { 'autoload' : {
      \ 'commands' : 'ConqueTerm'
      \ }}
NeoBundleLazy 'sjl/gundo.vim', { 'autoload' : {
      \ 'commands' : 'GundoToggle'
      \ }}
NeoBundleLazy 'thinca/vim-prettyprint', { 'autoload' : {
      \ 'commands' : 'PP'
      \ }}
NeoBundleLazy 'thinca/vim-qfreplace', { 'autoload' : {
      \ 'filetypes' : ['unite', 'quickfix'],
      \ }}
NeoBundleLazy 'thinca/vim-quickrun', { 'autoload' : {
      \ 'mappings' : [
      \   ['nxo', '<Plug>(quickrun)']],
      \ }}
NeoBundle 'thinca/vim-ref', { 'autoload' : {
      \ 'commands' : ['Ref', 'Unite']
      \ }}
NeoBundle 'mojako/ref-sources.vim', { 'autoload' : {
      \ 'commands' : ['Ref', 'Unite']
      \ }}
NeoBundle 'soh335/vim-ref-jquery', { 'autoload' : {
      \ 'commands' : ['Ref', 'Unite']
      \ }}
NeoBundle 'thinca/vim-unite-history', { 'autoload' : {
      \ 'unite_sources' : ['history/command', 'history/search']
      \ }}
NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload' : {
      \ 'mappings' : '<Plug>(ref-keyword)',
      \ 'filetypes' : 'ruby'
      \ }}
NeoBundleLazy 'tsukkee/lingr-vim', { 'autoload' : {
      \ 'commands' : 'LingrLaunch'
      \ }}
if has('gui_running') && !s:is_windows
  NeoBundleDisable lingr-vim
endif
NeoBundleLazy 'basyura/J6uil.vim.git', {
      \ 'autoload' : {
      \   'commands' : 'J6uil',
      \ },
      \ 'depends' : 'mattn/webapi-vim',
      \ }
NeoBundleLazy 'Shougo/unite-help', { 'autoload' : {
      \ 'unite_sources' : 'help'
      \ }}
NeoBundleLazy 'tsukkee/unite-tag', { 'autoload' : {
      \ 'unite_sources' : 'tag'
      \ }}
NeoBundle 'tyru/open-browser.vim', { 'autoload' : {
      \ 'filetypes' : 'markdown',
      \ 'mappings' : [
      \   '<Plug>(quickrun)', '<Plug>(open-browser-wwwsearch)']
      \ }}
NeoBundleLazy 'tyru/operator-html-escape.vim'
NeoBundleLazy 'tyru/vim-altercmd'
NeoBundleLazy 'ujihisa/neco-ghc', { 'autoload' : {
      \ 'filetypes' : 'haskell'
      \ }}
NeoBundle 'ujihisa/neco-look'
NeoBundleLazy 'ujihisa/unite-colorscheme', { 'autoload' : {
      \ 'unite_sources' : 'colorscheme',
      \ }}
NeoBundleLazy 'ujihisa/unite-locate', { 'autoload' : {
      \ 'unite_sources' : 'locate',
      \ }}
NeoBundle 'vim-jp/vimdoc-ja.git'
NeoBundleLazy 'yuratomo/w3m.vim', { 'autoload' : {
      \ 'commands' : 'W3m',
      \ }}
NeoBundleLazy 'pasela/unite-webcolorname', { 'autoload' : {
      \ 'unite_sources' : 'webcolorname',
      \ }}
NeoBundleLazy 'osyo-manga/unite-quickfix', { 'autoload' : {
      \ 'unite_sources' : 'quickfix',
      \ }}
NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {
      \ 'unite_sources' : 'filetype',
      \ }}
NeoBundleLazy 'basyura/unite-rails', { 'autoload' : {
      \ 'unite_sources' : 'rails',
      \ }}
NeoBundleLazy 'ujihisa/unite-rake', { 'autoload' : {
      \ 'unite_sources' : 'rake',
      \ }}
NeoBundleLazy 'rbtnn/hexript.vim'
NeoBundleLazy 'tpope/vim-endwise'
NeoBundleLazy 'kana/vim-tabpagecd'
NeoBundleLazy 'rhysd/accelerated-jk', { 'autoload' : {
      \ 'mappings' : ['<Plug>(accelerated_jk_gj)',
      \               '<Plug>(accelerated_jk_gk)'],
      \ }}
NeoBundleLazy 'vim-jp/autofmt', { 'autoload' : {
      \ 'mappings' : [['x', 'gq']],
      \ }}
NeoBundleLazy 'deton/jasegment.vim', { 'autoload' : {
      \ 'mappings' : [['n', '<Plug>JaSegmentMoveNE'],
      \               ['n', '<Plug>JaSegmentMoveNW'],
      \               ['n', '<Plug>JaSegmentMoveNB'],
      \               ['o', '<Plug>JaSegmentMoveOE'],
      \               ['o', '<Plug>JaSegmentMoveOW'],
      \               ['o', '<Plug>JaSegmentMoveOB'],
      \               ['x', '<Plug>JaSegmentMoveVE'],
      \               ['x', '<Plug>JaSegmentMoveVW'],
      \               ['x', '<Plug>JaSegmentMoveVB'],
      \ ],
      \ }}
NeoBundleLazy 'wesleyche/SrcExpl', { 'autoload' : { 'commands' : ['SrcExplToggle', 'SrcExpl', 'SrcExplClose'] } }

" From vim.org
NeoBundleLazy 'godlygeek/csapprox', { 'terminal' : 1 }
NeoBundleLazy 'thinca/vim-guicolorscheme', { 'terminal' : 1 }
NeoBundleLazy 'autodate.vim', { 'autoload' : {
      \ 'filetypes' : 'vim',
      \ }}
NeoBundleLazy 'matchit.zip', { 'autoload' : {
      \ 'filetypes' : 'vim',
      \ }}

" NeoBundle 'perl-mauke.vim'
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', { 'autoload' : {
      \ 'filetypes' : 'javascript',
      \ }}
NeoBundleLazy 'jelera/vim-javascript-syntax', { 'autoload' : {
      \ 'filetypes' : 'javascript',
      \ }}
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', { 'autoload' : {
      \ 'filetypes' : 'javascript',
      \ }}
NeoBundleLazy 'bkad/CamelCaseMotion', { 'autoload' : {
      \ 'mappings' : ['<Plug>CamelCaseMotion_w',
      \               '<Plug>CamelCaseMotion_b'],
      \ }}
NeoBundleLazy 'HybridText', { 'autoload' : {
      \ 'filetypes' : 'hybrid',
      \ }}
NeoBundleLazy 'AndrewRadev/switch.vim', { 'autoload' : {
      \ 'commands' : 'Switch',
      \ }}
NeoBundleLazy 'kana/vim-niceblock', { 'autoload' : {
      \ 'mappings' : ['<Plug>(niceblock-I)', '<Plug>(niceblock-A)']
      \ }}
NeoBundleLazy 'aharisu/vim-gdev', { 'autoload' : {
      \ 'filetypes' : 'scheme',
      \ }}
NeoBundleLazy 'vim-jp/cpp-vim', { 'autoload' : {
      \ 'filetypes' : 'cpp',
      \ }}
NeoBundleLazy 'thinca/vim-ft-diff_fold', { 'autoload' : {
      \ 'filetypes' : 'diff'
      \ }}
NeoBundleLazy 'thinca/vim-ft-markdown_fold', { 'autoload' : {
      \ 'filetypes' : 'markdown'
      \ }}
NeoBundleLazy 'teramako/jscomplete-vim', {
      \ 'autoload' : {
      \   'filetypes' : 'javascript'
      \ }}
NeoBundleLazy 'myhere/vim-nodejs-complete', {
      \ 'autoload' : {
      \   'filetypes' : 'javascript'
      \ }}

if has('python')
  NeoBundleLazy 'marijnh/tern_for_vim', {
        \ 'build' : {'others': 'npm install'},
        \ 'autoload' : {
        \   'filetypes' : 'javascript'
        \ }}
endif

NeoBundleLazy 'thinca/vim-ft-help_fold', {
      \ 'autoload' : {
      \   'filetypes' : 'help'
      \ }}

if has('conceal')
  NeoBundle 'Yggdroot/indentLine'
endif

NeoBundleLazy 'itchyny/thumbnail.vim', {
      \ 'autoload' : {
      \   'commands' : 'Thumbnail'
      \ }}
NeoBundleLazy 'xolox/vim-lua-ftplugin', {
      \ 'autoload' : {
      \   'filetypes' : 'lua',
      \ }}
NeoBundleLazy 'elzr/vim-json', {
      \ 'autoload' : {
      \   'filetypes' : 'json',
      \ }}
NeoBundle 'spolu/dwm.vim', '', 'default'
NeoBundle 'kannokanno/unite-dwm', { 'autoload' : {
      \ 'commands' : 'Unite'
      \ }}
NeoBundle 'altercation/vim-colors-solarized', '', 'default'
NeoBundle 'tpope/vim-fugitive', '', 'default'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Townk/vim-autoclose', '', 'default'
NeoBundleLazy 'vim-scripts/jQuery', { 'autoload' : {
      \ 'filetypes' : ['javascript',
      \ 'json']
      \ }}
NeoBundle 'majutsushi/tagbar', { 'autoload' : {
      \ 'commands' : 'TagbarToggle'
      \ }}
" NeoBundle 'nathanaelkane/vim-indent-guides', '', 'default'
NeoBundle 'mustardamus/jqapi', { 'autoload' : {
      \ 'commands' : ['Ref', 'Unite']
      \ }}
NeoBundle 'tokuhirom/jsref', { 'autoload' : {
      \ 'commands' : ['Ref', 'Unite']
      \ }}
NeoBundle 'taka84u9/vim-ref-ri', { 'autoload' : {
      \ 'commands' : ['Ref', 'Unite']
      \ }}
" NeoBundle 'terryma/vim-expand-region', '', 'default'
" NeoBundle 'terryma/vim-smooth-scroll', '', 'default'
" NeoBundle 'tpope/vim-surround', '', 'default'
" NeoBundle 'tpope/vim-speeddating', '', 'default'
" NeoBundle 'tpope/vim-abolish', '', 'default'
" NeoBundle 'tpope/vim-unimpaired', '', 'default'
" NeoBundle 'tpope/vim-commentary', '', 'default'
NeoBundleLazy 'tpope/vim-repeat', { 'autoload' : {
      \ 'mappings' : '.',
      \ }}
" NeoBundleLazy 'othree/eregex.vim', { 'autoload' : {
"       \ 'insert' : 1,
"       \ }}
NeoBundleLazy 'glidenote/memolist.vim', { 'autoload' : {
      \ 'insert' : 1,
      \ 'commands' : ['MemoNew', 'MemoList', 'MemoGrep']
      \ }}
NeoBundleLazy 'kmnk/vim-unite-giti', { 'autoload' : {
      \ 'unite_sources' : ['giti']
      \ }}
NeoBundleLazy 'kmnk/vim-unite-svn', { 'autoload' : {
      \ 'unite_sources' : ['svn']
      \ }}
NeoBundle 'editorconfig/editorconfig-vim', '', 'default'
NeoBundleLazy 'jnwhiteh/vim-golang', {
      \ 'autoload' : {
      \   'filetypes' : 'go'
      \ }}
NeoBundleLazy 'Blackrush/vim-gocode', {
      \ 'autoload' : {
      \   'filetypes' : 'go'
      \ }}
NeoBundleLazy 'techlivezheng/vim-plugin-tagbar-phpctags', {
      \ 'autoload' : {
      \   'filetypes' : 'php'
      \ }}
NeoBundle 'Lokaltog/vim-easymotion', '', 'default'
NeoBundle 'zhisheng/visualmark.vim', '', 'default'
NeoBundleLazy 'tpope/vim-markdown', { 'autoload' : {
      \ 'filetypes' : 'markdown'
      \ }}
NeoBundleLazy 'aaronbieber/quicktask', { 'autoload' : {
      \ 'filetypes' : 'quicktask'
      \ }}
NeoBundleLazy 'davidoc/taskpaper.vim', { 'autoload' : {
      \ 'filetypes' : 'taskpaper'
      \ }}
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundleLazy 'mattn/emmet-vim',  { 'autoload' : {
      \ 'filetypes' : ['html','haml','slim','css','js','php']
      \ }}
NeoBundle 'cohama/vim-insert-linenr'
NeoBundle 'taichouchou2/alpaca_powertabline'
NeoBundle 'guyht/vimwiki', 'alt-font'


NeoBundleLocal ~/.vim/bundle
"}}}


" Disable menu.vim
if has('gui_running')
  set guioptions=Mc
endif
" Disable GetLatestVimPlugin.vim
let g:loaded_getscriptPlugin = 1
" Disable netrw.vim
let g:loaded_netrwPlugin = 1

filetype plugin indent on

" Enable syntax color.
syntax enable

" Installation check.
NeoBundleCheck
"}}}

"---------------------------------------------------------------------------
" Encoding:"{{{
"
" The automatic recognition of the character code.

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
set encoding=utf-8

" Setting of terminal encoding."{{{
if !has('gui_running')
  if &term ==# 'win32' &&
        \ (v:version < 703 || (v:version == 703 && has('patch814')))
    " Setting when use the non-GUI Japanese console.

    " Garbled unless set this.
    set termencoding=cp932
    " Japanese input changes itself unless set this.  Be careful because the
    " automatic recognition of the character code is not possible!
    set encoding=japan
  else
    if $ENV_ACCESS ==# 'linux'
      set termencoding=euc-jp
    elseif $ENV_ACCESS ==# 'colinux'
      set termencoding=utf-8
    else  " fallback
      set termencoding=  " same as 'encoding'
    endif
  endif
elseif s:is_windows
  " For system.
  set termencoding=cp932
endif
"}}}

" The automatic recognition of the character code."{{{
if !exists('did_encoding_settings') && has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Build encodings.
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis

  let did_encoding_settings = 1
endif
"}}}

if has('kaoriya')
  " For Kaoriya only.
  set fileencodings=guess
endif

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() "{{{
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction"}}}

autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

" Command group opening with a specific character code again."{{{
" In particular effective when I am garbled in a terminal.
" Open in UTF-8 again.
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
" Open in iso-2022-jp again.
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
" Open in Shift_JIS again.
command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
" Open in EUC-jp again.
command! -bang -bar -complete=file -nargs=? Euc edit<bang> ++enc=euc-jp <args>
" Open in UTF-16 again.
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
" Open in UTF-16BE again.
command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
"}}}

" Tried to make a file note version."{{{
" Don't save it because dangerous.
command! WUtf8 setlocal fenc=utf-8
command! WIso2022jp setlocal fenc=iso-2022-jp
command! WCp932 setlocal fenc=cp932
command! WEuc setlocal fenc=euc-jp
command! WUtf16 setlocal fenc=ucs-2le
command! WUtf16be setlocal fenc=ucs-2
" Aliases.
command! WJis  WIso2022jp
command! WSjis  WCp932
command! WUnicode WUtf16
"}}}

" Appoint a line feed."{{{
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
command! -bang -complete=file -nargs=? WMac
      \ write<bang> ++fileformat=mac <args> | edit <args>
"}}}

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif
"}}}

"---------------------------------------------------------------------------
" Search:"{{{
"
" Ignore the case of normal letters.
set ignorecase
" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Enable incremental search.
set incsearch
" Don't highlight search result.
"set nohlsearch
" Enable highlight search result.
set hlsearch

" Don't Search wrap around the end of the file.
set nowrapscan
"}}}

"---------------------------------------------------------------------------
" Edit:"{{{
"

" Smart insert tab setting.
set smarttab
" Exchange tab to spaces.
set expandtab
" Substitute <Tab> with blanks.
"set tabstop=8
" Spaces instead <Tab>.
"set softtabstop=4
" Autoindent width.
"set shiftwidth=4
" Round indent by shiftwidth.
set shiftround

" Enable modeline.
set modeline

" Use clipboard register.
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" Disable auto wrap.
autocmd MyAutoCmd FileType *
      \ if &l:textwidth != 70 && &filetype !=# 'help' |
      \    setlocal textwidth=0 |
      \ endif

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Highlight parenthesis.
set showmatch
" Highlight when CursorMoved.
set cpoptions-=m
set matchtime=3
" Highlight <>.
set matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
set hidden

" Auto reload if file is changed.
"set autoread

" Ignore case on insert completion.
set infercase

" Search home directory path on cd.
" But can't complete.
" set cdpath+=~

" Enable folding.
set foldenable
" set foldmethod=expr
" set foldmethod=indent
set foldmethod=marker
" Show folding level.
set foldcolumn=0
set fillchars=vert:\|
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set commentstring=%s
set foldtext=foldCC#foldtext()
let g:foldCCtext_enable_autofdc_adjuster = 1


" set grepprg=internal
" set grepprg=grep\ -nH
" set grepprg=git\ grep\ -n
set grepprg=ag\ --ignore-case\ --skip-vcs-ignores
" set grepprg=jvgrep

" Exclude = from isfilename.
set isfname-==

" Reload .vimrc and .gvimrc automatically.
if !has('gui_running') && !s:is_windows
  autocmd MyAutoCmd BufWritePost .vimrc nested source $MYVIMRC |
        \ call s:set_syntax_of_user_defined_commands() |
        \ echo "source $MYVIMRC"
else
  autocmd MyAutoCmd BufWritePost .vimrc source $MYVIMRC |
        \ call s:set_syntax_of_user_defined_commands() |
        \ if has('gui_running') | source $MYGVIMRC | echo "source $MYVIMRC"
  autocmd MyAutoCmd BufWritePost .gvimrc
        \ if has('gui_running') | source $MYGVIMRC | echo "source $MYGVIMRC"
endif

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
set updatetime=1000

" Set swap directory.
set directory-=.

if v:version >= 703
  " Set undofile.
  set undofile
  let &undodir=&directory
endif

" Set tags file.
" Don't search tags file in current directory. And search upward.
set tags& tags-=tags tags+=./tags;
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  " Vim's bug.
  set notagbsearch
endif

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help.
set keywordprg=:help

" Check timestamp more for 'autoread'.
autocmd MyAutoCmd WinEnter * checktime

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Use autofmt.
set formatexpr=autofmt#japanese#formatexpr()
"}}}

"---------------------------------------------------------------------------
" View:"{{{
"
" Show line number.
"set number
" Show <TAB> and <CR>
set list
if s:is_windows
  set listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif
" Do not wrap long line.
set nowrap
" Wrap conditions.
set whichwrap+=h,l,<,>,[,],b,s,~
" Always display statusline.
set laststatus=2
" Height of command line.
set cmdheight=2
" Not show command on statusline.
" set noshowcmd
" Not show mode.
" set noshowmode
" Show title.
set title
" Title length.
set titlelen=95
" Title string.
let &titlestring="
      \ %{(&filetype ==# 'lingr-messages' && lingr#unread_count() > 0 )?
      \ '('.lingr#unread_count().')' : ''}%{expand('%:p:.:~')}%(%m%r%w%)
      \ %<\(%{".s:SID_PREFIX()."strwidthpart(
      \ fnamemodify(&filetype ==# 'vimfiler' ?
      \ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
      \ &columns-len(expand('%:p:.:~')))}\) - VIM"

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''

  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears

    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '

    " Use gettabvar().
    let title =
          \ !exists('*gettabvar') ?
          \      fnamemodify(bufname(bufnr), ':t') :
          \ gettabvar(i, 'title') != '' ?
          \      gettabvar(i, 'title') :
          \      fnamemodify(gettabvar(i, 'cwd'), ':t')

    let title = '[' . title . ']'

    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor

  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
" let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" Set statusline.
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
      \ . "%{(&previewwindow?'[preview] ':'').expand('%:t:.')}"
      \ . "%{fugitive#statusline()}"
      \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
      \ . "%{printf(' %5d/%d',line('.'),line('$'))}"

" Turn down a long line appointed in 'breakat'
set linebreak
set showbreak=>\
set breakat=\ \	;:,!?

" Do not display greetings message at the time of Vim start.
set shortmess=aTI

" Don't create backup.
set nowritebackup
set nobackup
set backupdir-=.

" Disable bell.
set t_vb=
set novisualbell

" Display candidate supplement.
" set nowildmenu
set wildmode=list:longest,full
set wildmenu "{{{
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
"}}}
" Increase history amount.
set history=200
" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag
" Can supplement a tag in a command-line.
set wildoptions=tagfile

" Enable spell check.
set spelllang=en_us

" Completion setting.
set completeopt=menuone
" Don't complete from other buffer.
set complete=.
"set complete=.,w,b,i,t
" Set popup menu max height.
set pumheight=20

" Report changes.
set report=0

" Maintain a current line at the time of movement as much as possible.
set nostartofline

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright
" Set minimal width for current window.
set winwidth=30
" Set minimal height for current window.
set winheight=20
" set winheight=1
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways

" Adjust window size of preview and help.
set previewheight=8
set helpheight=12

" Don't redraw while macro executing.
set lazyredraw

" When a line is long, do not omit it in @.
set display=lastline
" Display an invisible letter with hex format.
"set display+=uhex

" Disable automatically insert comment.
autocmd MyAutoCmd FileType *
      \ setl formatoptions-=ro | setl formatoptions+=mM

if v:version >= 703
  " For conceal.
  set conceallevel=2 concealcursor=iv

  set colorcolumn=79
endif

" View setting.
set viewdir=~/.vim/view
set viewoptions-=options
set viewoptions+=slash,unix
set viewoptions+=cursor,folds

" Diff
set diffopt=filler,icase,iwhite

" Show current cursorline
set cursorline
"}}}

"---------------------------------------------------------------------------
" Syntax:"{{{
"
" Enable smart indent.
set autoindent smartindent

augroup MyAutoCmd
  " Go previous editing line when file open
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

  " typescript
  autocmd BufRead,BufNewFile *.ts setl filetype=typescript

  " less
  autocmd BufRead,BufNewFile *.less setl filetype=less

  " applescript
  autocmd BufRead,BufNewFile *.applescript,*.scpt setl filetype=applescript
  autocmd FileType applescript inoremap <buffer> <S-CR>  ￢<CR>

  " Enable gauche syntax.
  autocmd FileType scheme nested let b:is_gauche=1 | setlocal lispwords=define |
        \let b:current_syntax='' | syntax enable

  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim if &autoread
        \ | source <afile> | echo 'source ' . bufname('%') | endif

  " Manage long Rakefile easily
  autocmd BufNewfile,BufRead Rakefile setlocal foldmethod=syntax foldnestmax=1

  " Go
  autocmd BufWritePre *.go Fmt

  " Markdown
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setfiletype markdown

  " Json
  autocmd BufNewfile,BufRead *.json,*.gyp,*.bowerrc,*.jshintrc setfiletype json

  " Close help and git window by pressing q.
  autocmd FileType help,git-status,git-log,qf,
        \gitcommit,git,gitrebase,gitsendemail,quickrun,qfreplace,ref
        \ nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>
  autocmd FileType * if (&readonly || !&modifiable) && !hasmapto('q', 'n')
        \ | nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>| endif

  autocmd FileType gitcommit,qfreplace setlocal nofoldenable

  " Open quickfix after make, grep
  autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd if len(getqflist()) != 0 | cwindow | endif

  " TagBar
  " autocmd FileType ada,c,cpp,coffee,go,groovy,haskell,html,
  "       \java,javascript,markdown,
  "       \perl,php,python,ruby,scala,
  "       \tex,vhdl,vim,xml,xquery
  "       \ nested :TagbarOpen

  " Enable omni completion.
  autocmd FileType ada setlocal omnifunc=adacomplete#Complete
  autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd BufNewFile,BufRead,BufEnter *.cpp,*.hpp setlocal omnifunc=omni#cpp#complete#Main
  autocmd FileType cpp setlocal omnifunc=cppcomplete#CompleteCPP
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType go setlocal omnifunc=gocomplete#Complete
  autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  if has('python3')
    autocmd FileType python setlocal omnifunc=python3complete#Complete
  else
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  endif
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Update filetype.
  autocmd BufWritePost *
  \ if &l:filetype ==# '' || exists('b:ftdetect')
  \ |   unlet! b:ftdetect
  \ |   filetype detect
  \ | endif

  autocmd BufEnter,BufNewFile * if bufname('%') != '' && &filetype == ''
        \ | setlocal ft=hybrid | endif

  " Mercurial unified tests
  autocmd BufNewFile,BufRead *.t set filetype=hgtest | let hgtest_fold=1
  autocmd Syntax hgtest setlocal foldlevel=1

  autocmd BufRead,BufNewFile .vimperatorrc setfiletype vimperator |setlocal commentstring=\ \"%s

  " Improved include pattern.
  autocmd FileType html
        \ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
        \ setlocal path+=./;/
  autocmd FileType php setlocal path+=/usr/local/share/pear
  autocmd FileType apache setlocal path+=./;/

  " Set sw/sts/ts.
  " sw  : shiftwidth (インデント時に使用されるスペースの数)
  " sts : softtabstop (0でないなら、タブを入力時、その数値分だけ半角スペースを挿入)
  " ts  : tabstop (タブを画面で表示する際の幅)
  " et  : expandtab (有効時、タブを半角スペースとして挿入)
  " ml  : modeline
  " tw  : textwidth
  " modeline : モードラインを有効
  " http://nanasi.jp/articles/howto/file/modeline.html
  autocmd!
  autocmd FileType apache       setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType aspvbs       setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType c            setlocal sw=4 sts=4 ts=4 et fdm=syntax
  autocmd FileType coffee       setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType cpp          setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType cs           setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType csh          setlocal sw=4 sts=4 ts=4 et fdm=marker
  autocmd FileType css          setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType diff         setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType eruby        setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType gitcommit    setlocal sw=4 sts=4 ts=4 et fdm=indent tw=72
  autocmd FileType gitconfig    setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType haml         setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType hgtest       setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType html         setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType java         setlocal sw=4 sts=4 ts=4 noet fdm=syntax
  autocmd FileType javascript   setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType json         setlocal sw=2 sts=2 ts=2 et fdm=syntax conceallevel=1
  autocmd FileType less         setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType make         setlocal sw=4 sts=4 ts=4 noet fdm=indent
  autocmd FileType perl         setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType php          setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType python       setlocal sw=4 sts=4 ts=8 et fdm=indent tw=80
  autocmd FileType quicktask    setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType ruby         setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType scala        setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType sh           setlocal sw=4 sts=4 ts=4 et fdm=marker
  autocmd FileType sql          setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType typescript   setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType taskpaper    setlocal sw=2 sts=2 ts=2 noet fdm=indent
  autocmd FileType vb           setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType vim          setlocal sw=2 sts=2 ts=2 et fdm=marker
  autocmd FileType vimperatorrc setlocal sw=2 sts=2 ts=2 et fdm=marker
  autocmd FileType wsh          setlocal sw=4 sts=4 ts=4 et fdm=indent
  autocmd FileType xhtml        setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType xml          setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType yaml         setlocal sw=2 sts=2 ts=2 et fdm=indent
  autocmd FileType zsh          setlocal sw=4 sts=4 ts=4 et fdm=marker
augroup END

" PHP
let g:php_folding = 0

" Python
let g:python_highlight_all = 1

" XML
let g:xml_syntax_folding = 1

" Vim
let g:vimsyntax_noerror = 1
"let g:vim_indent_cont = 0

" Bash
let g:is_bash = 1

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" JavaScript
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Vim script
" augroup: a
" function: f
" lua: l
" perl: p
" ruby: r
" python: P
" tcl: t
" mzscheme: m
let g:vimsyn_folding = 'af'

" Syntax highlight for user commands.
augroup syntax-highlight-extends
  autocmd!
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

function! s:set_syntax_of_user_defined_commands()
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names == '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction

" Clear modeline highlight.
autocmd MyAutoCmd VimEnter * highlight ModeMsg guifg=bg guibg=bg

"}}}

"---------------------------------------------------------------------------
" Plugin:"{{{
"
" neocomplete.vim"{{{
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

let bundle = neobundle#get('neocomplete.vim')
function! bundle.hooks.on_source(bundle)
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_fuzzy_completion = 0
  let g:neocomplete#enable_camel_case_completion = 0
  let g:neocomplete#enable_underbar_completion = 0
  let g:neocomplete#disable_caching_file_path_pattern =
        \ "\.log$\|_history$\|\.howm$\|\.jax$\|\.snippets$"
  let g:neocomplete#lock_buffer_name_pattern =
        \ '\*ku\*\|\.log$\|\.jax$\|\.log\.'

  let g:neocomplete#sources#syntax#min_keyword_length = 2
  let g:neocomplete#auto_completion_start_length = 2
  let g:neocomplete#manual_completion_start_length = 2
  let g:neocomplete#min_keyword_length = 2

  " For auto select.
  " let g:neocomplete#enable_complete_select = 1
  " let g:neocomplete#enable_auto_select = 1
  " let g:neocomplete#enable_refresh_always = 1
  " if g:neocomplete#enable_complete_select
  "   set completeopt-=noselect
  "   set completeopt+=noinsert
  " endif

  let g:neocomplete#enable_auto_delimiter = 1
  let g:neocomplete#enable_auto_close_preview = 1
  let g:neocomplete#disable_auto_select_buffer_name_pattern =
        \ '\[Command Line\]'
  let g:neocomplete#max_list = 100
  let g:neocomplete#force_overwrite_completefunc = 1

  if !exists('g:neocomplete#sources#omni#functions')
    let g:neocomplete#sources#omni#functions = {}
  endif
  let g:neocomplete#sources#omni#functions.clojure = 'vimclojure#OmniCompletion'
  let g:neocomplete#sources#omni#functions.go = 'gocomplete#Complete'
  let g:neocomplete#sources#omni#functions.javascript = 'nodejscomplete#CompleteJS'
  let g:neocomplete#sources#omni#functions.sql = 'sqlcomplete#Complete'

  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"]|\w)(\.|\()\w*'
  let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  " let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


  " Define same filetypes
  if !exists('g:neocomplete#same_filetypes')
    let g:neocomplete#same_filetypes = {}
  endif
  let g:neocomplete#same_filetypes.c = 'cpp,d'
  let g:neocomplete#same_filetypes.cpp = 'c'
  let g:neocomplete#same_filetypes.gitconfig = '_'
  let g:neocomplete#same_filetypes.javascript = 'json'
  let g:neocomplete#same_filetypes.json = 'javascript'
  let g:neocomplete#same_filetypes._ = '_'

  " Define keyword pattern.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '[0-9a-zA-Z:#_]\+'
  let g:neocomplete#keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

  let g:neocomplete#sources#vim#complete_functions = {
        \ 'Ref' : 'ref#complete',
        \ 'Unite' : 'unite#complete_source',
        \ 'VimFiler' : 'vimfiler#complete',
        \ 'Vinarise' : 'vinarise#complete',
        \}
  call neocomplete#custom#source('look', 'min_pattern_length', 2)

  " Add directory files
  if !exists('g:neocomplete#sources#dictionary#dictionaries')
    let g:neocomplete#sources#dictionary#dictionaries = {}
  endif
  function! s:neocomplete_dictionary_config() "{{{
    for fp in split(globpath("~/.vim/dict", "*.dict"), "\n")
      let _name = fnamemodify(fp, ":p:r")
      let g:neocomplete#sources#dictionary#dictionaries[_name] = fp
    endfor

    call extend(g:neocomplete#sources#dictionary#dictionaries, {
          \ 'default'     : '',
          \ 'javascript'  : $HOME . '/.vim/dict/node.dict',
          \ 'eruby'       : $HOME . '/.vim/dict/ruby.dict',
          \ })
  endfunction "}}}
  call s:neocomplete_dictionary_config()

  " mappings."{{{
  " <C-f>, <C-b>: page move.
  inoremap <expr><C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
  inoremap <expr><C-b>  pumvisible() ? "\<PageUp>"   : "\<Left>"
  " <C-y>: paste.
  inoremap <expr><C-y>  pumvisible() ? neocomplete#close_popup() :  "\<C-r>\""
  " <C-e>: close popup.
  inoremap <expr><C-e>  pumvisible() ? neocomplete#cancel_popup() : "\<End>"
  " <C-k>: unite completion.
  imap <C-k>  <Plug>(neocomplete_start_unite_complete)
  " inoremap <expr> O  &filetype == 'vim' ? "\<C-x>\<C-v>" : "\<C-x>\<C-o>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " <C-n>: neocomplete.
  inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"
  " <C-p>: keyword completion.
  inoremap <expr><C-p>  pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
  inoremap <expr>'  pumvisible() ? neocomplete#close_popup() : "'"

  imap <expr> `  pumvisible() ?
        \ "\<Plug>(neocomplete_start_unite_quick_match)" : '`'

  inoremap <expr><C-x><C-f>
        \ neocomplete#start_manual_complete('filename_complete')

  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
  endfunction

  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
  function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}
  " <S-TAB>: completion back.
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

  " For cursor moving in insert mode(Not recommended)
  inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  "}}}
endfunction
"}}}

" neosnippet.vim"{{{
let bundle = neobundle#get('neosnippet')
function! bundle.hooks.on_source(bundle)
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  let g:neosnippet#enable_snipmate_compatibility = 1

  let g:neosnippet#snippets_directory = '~/.vim/snippets'
endfunction

unlet bundle

nnoremap <silent> [Window]f              :<C-u>Unite neosnippet/user neosnippet/runtime<CR>

"}}}

" vinarise.vim"{{{
let g:vinarise_enable_auto_detect = 1
"}}}

" unite.vim"{{{
" The prefix key.
nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap    ; [unite]
xmap    ; [unite]
cabbrev unite Unite


nnoremap [unite]re  :<C-u>UniteResume<CR>
nnoremap [unite]f   :<C-u>Unite -buffer-name=files file file/new file_rec/async:! <CR>
nnoremap [unite]mr  :<C-u>Unite -buffer-name=files file_mru bookmark<CR>
nnoremap [unite]b   :<C-u>Unite -buffer-name=files buffer buffer_tab tab dwm<CR>
nnoremap [unite]so  :<C-u>Unite -buffer-name=files source<CR>
nnoremap [unite]o   :<C-u>Unite outline -vertical -winwidth=30 -no-quit -resume<CR>
nnoremap [unite]ma  :<C-u>Unite -start-insert output:map<Bar>map!<Bar>lmap<CR>
nnoremap [unite]me  :<C-u>Unite output:message<CR>
nnoremap [unite]di  :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap [unite]ta  :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
nnoremap [unite]y   :<C-u>Unite -buffer-name=register register history/yank<CR>
nnoremap [unite]gr  :<C-u>Unite grep -buffer-name=search -auto-preview -no-quit -resume<CR>
nnoremap [unite]h   :<C-u>Unite -buffer-name=help help<CR>
nnoremap [unite]k   :<C-u>UniteWithCursorWord -buffer-name=help help<CR>
nnoremap [unite]rr  :<C-u>UniteWithCursorWord -buffer-name=help ref/refe<CR>
nnoremap [unite]ri  :<C-u>UniteWithCursorWord -buffer-name=help ref/ri<CR>
nnoremap [unite]gi  :<C-u>Unite -buffer-name=git giti<CR>
vnoremap /g y:Unite grep::-i:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
nnoremap <silent> [Space]b :<C-u>UniteBookmarkAdd<CR>

" t: tags-and-searches "{{{
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Jump.
" nnoremap [Tag]t  <C-]>
nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "\<C-]>" :
      \ ":\<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include\<CR>"
nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
      \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"
"}}}

" Search.
nnoremap <silent> [Alt]/
      \ :<C-u>Unite -buffer-name=search -auto-preview -start-insert line:forward<CR>
nnoremap <expr> g/  <SID>smart_search_expr('g/',
      \ ":\<C-u>Unite -buffer-name=search -auto-preview -start-insert line_migemo\<CR>")
nnoremap <silent> [Alt]?
      \ :<C-u>Unite -buffer-name=search -auto-preview -start-insert line:backward<CR>
nnoremap <silent> [Alt]*
      \ :<C-u>UniteWithCursorWord -buffer-name=search -auto-preview line:forward<CR>
nnoremap <silent> [Alt]#
      \ :<C-u>UniteWithCursorWord -buffer-name=search -auto-preview line:backward<CR>
"nnoremap [Alt]/       /
"nnoremap [Alt]?       ?
cnoremap <expr><silent><C-g>        (getcmdtype() == '/') ?
      \ "\<ESC>:Unite -buffer-name=search -no-split line -input=".getcmdline()."\<CR>" : "\<C-g>"

function! s:smart_search_expr(expr1, expr2)
  return line('$') > 5000 ?  a:expr1 : a:expr2
endfunction

nnoremap <silent> [Alt]n  :<C-u>UniteResume search -no-start-insert<CR>

let g:unite_source_history_yank_enable = 1

" For unite-alias. "{{{
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
"}}}
" For unite-menu."{{{
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
nnoremap <silent> [unite];e :<C-u>Unite menu:enc<CR>

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
nnoremap <silent> [unite];f :<C-u>Unite menu:fenc<CR>

let g:unite_source_menu_menus.ff = {
      \     'description' : 'Change file format option.',
      \ }
let g:unite_source_menu_menus.ff.command_candidates = {
      \       'unix'   : 'WUnix',
      \       'dos'    : 'WDos',
      \       'mac'    : 'WMac',
      \     }
nnoremap <silent> [unite];w :<C-u>Unite menu:ff<CR>

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
nnoremap <silent> [unite];u :<C-u>Unite menu:unite -resume<CR>
"}}}
let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle) "{{{
  autocmd MyAutoCmd FileType unite call s:unite_my_settings()

  call unite#set_profile('action', 'context', {'start_insert' : 1})

  " Set "-no-quit" automatically in grep unite source.
  call unite#set_profile('source/grep', 'context', {'no_quit' : 1})

  " migemo.
  call unite#custom_source('line_migemo', 'matchers', 'matcher_migemo')

  call unite#custom_source('file_rec', 'sorters', 'sorter_reverse')

  " Custom filters."{{{
  call unite#custom_source(
        \ 'buffer,file_rec/async,file_mru', 'matchers',
        \ ['converter_tail', 'matcher_fuzzy'])
  call unite#custom_source(
        \ 'file_rec', 'matchers', ['matcher_fuzzy'])
  call unite#custom_source(
        \ 'file_rec/async,file_mru', 'converters',
        \ ['converter_file_directory'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  "}}}

  function! s:unite_my_settings() "{{{
    " Directory partial match.
    call unite#custom#substitute('files', '^\.v/',
          \ [expand('~/.vim/'), unite#util#substitute_path_separator($HOME)
          \ . '/.bundle/*/'], 1000)
    call unite#custom_alias('file', 'h', 'left')
    call unite#custom_default_action('directory', 'narrow')
  " call unite#custom#default_action('file', 'my_tabopen')

    call unite#custom_default_action('versions/git/status', 'commit')

  " call unite#custom_default_action('directory', 'cd')

    " Custom actions."{{{
    let my_tabopen = {
          \ 'description' : 'my tabopen items',
          \ 'is_selectable' : 1,
          \ }
    function! my_tabopen.func(candidates) "{{{
      call unite#take_action('tabopen', a:candidates)

      let dir = isdirectory(a:candidates[0].word) ?
            \ a:candidates[0].word : fnamemodify(a:candidates[0].word, ':p:h')
      execute g:unite_kind_openable_lcd_command '`=dir`'
    endfunction"}}}
    call unite#custom_action('file,buffer', 'tabopen', my_tabopen)
    unlet my_tabopen
    "}}}

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
    " nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    " nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    " imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    " nmap <silent><buffer> <Tab>     :call <SID>NextWindow()<CR>
    nnoremap <buffer><silent><C-h>   :<C-u>tabprevious<CR>
    nnoremap <buffer><silent><C-l>   :<C-u>tabnext<CR>
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
  endfunction "}}}

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
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-case'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('jvgrep')
    " For jvgrep.
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '--exclude ''\.(git|svn|hg|bzr)'' -i'
    let g:unite_source_grep_recursive_opt = '-R'
  elseif executable('ack-grep')
    " For ack.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '--no-heading --no-color --ignore-case'
    let g:unite_source_grep_recursive_opt = ''
  endif

  let g:unite_build_error_icon    = $DOTVIM . '/signs/err.'
        \ . (s:is_windows ? 'bmp' : 'png')
  let g:unite_build_warning_icon  = $DOTVIM . '/signs/warn.'
        \ . (s:is_windows ? 'bmp' : 'png')
endfunction "}}}

unlet bundle
"}}}

" smartword.vim"{{{
" Replace w and others with smartword-mappings
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap ge  <Plug>(smartword-ge)
xmap w  <Plug>(smartword-w)
xmap b  <Plug>(smartword-b)
" Operator pending mode.
omap <Leader>w  <Plug>(smartword-w)
omap <Leader>b  <Plug>(smartword-b)
omap <Leader>ge  <Plug>(smartword-ge)
"}}}

" camlcasemotion.vim"{{{
nmap <silent> [Alt]w <Plug>CamelCaseMotion_w
xmap <silent> [Alt]w <Plug>CamelCaseMotion_w
omap <silent> [Alt]w <Plug>CamelCaseMotion_w
nmap <silent> [Alt]b <Plug>CamelCaseMotion_b
xmap <silent> [Alt]b <Plug>CamelCaseMotion_b
omap <silent> [Alt]b <Plug>CamelCaseMotion_b
""}}}

" smartchr.vim"{{{
let bundle = neobundle#get('vim-smartchr')
function! bundle.hooks.on_source(bundle)
  inoremap <expr> , smartchr#one_of(', ', ',')

  " Smart =.
  inoremap <expr> =
        \ search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= '
        \ : search('\(*\<bar>!\)\%#', 'bcn') ? '= '
        \ : smartchr#one_of(' = ', '=', ' == ')
  augroup MyAutoCmd
    " Substitute .. into -> .
    autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#loop('.', '->', '...')
    autocmd FileType perl,php inoremap <buffer> <expr> . smartchr#loop(' . ', '->', '.')
    autocmd FileType perl,php inoremap <buffer> <expr> - smartchr#loop('-', '->')
    autocmd FileType vim inoremap <buffer> <expr> . smartchr#loop('.', ' . ', '..', '...')

    autocmd FileType haskell,int-ghci
          \ inoremap <buffer> <expr> + smartchr#loop('+', ' ++ ')
          \| inoremap <buffer> <expr> - smartchr#loop('-', ' -> ', ' <- ')
          \| inoremap <buffer> <expr> $ smartchr#loop(' $ ', '$')
          \| inoremap <buffer> <expr> \ smartchr#loop('\ ', '\')
          \| inoremap <buffer> <expr> : smartchr#loop(':', ' :: ', ' : ')
          \| inoremap <buffer> <expr> . smartchr#loop('.', ' . ', '..')

    autocmd FileType scala
          \ inoremap <buffer> <expr> - smartchr#loop('-', ' -> ', ' <- ')
          \| inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' => ')
          \| inoremap <buffer> <expr> : smartchr#loop(': ', ':', ' :: ')
          \| inoremap <buffer> <expr> . smartchr#loop('.', ' => ')

    autocmd FileType eruby
          \ inoremap <buffer> <expr> > smartchr#loop('>', '%>')
          \| inoremap <buffer> <expr> < smartchr#loop('<', '<%', '<%=')
  augroup END
endfunction

unlet bundle
"}}}

" smarttill.vim"{{{
xmap q  <Plug>(smarttill-t)
xmap Q  <Plug>(smarttill-T)
" Operator pending mode.
omap q  <Plug>(smarttill-t)
omap Q  <Plug>(smarttill-T)
"}}}

" changelog.vim"{{{
autocmd MyAutoCmd BufNewFile,BufRead *.changelog setf changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "h17u "
"}}}

" quickrun.vim"{{{
nmap <silent> <Leader>r <Plug>(quickrun)
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config['coffee'] = {
      \ 'command' : 'coffee',
      \ 'exec' : ['%c -cbp %s']
      \ }
let g:quickrun_config['markdown'] = {
      \ 'type': 'markdown/kramdown',
      \ 'outputter': 'browser',
      \ 'exec': '%c --input=markdown --output=html %o %s %a 2>/dev/null',
      \ }
let g:quickrun_config['html'] = {
      \ 'command' : 'cat',
      \ 'exec' : ['%c %s'],
      \ 'outputter': 'browser',
      \ 'hook/time/enable': '0'
      \ }
"}}}

" python.vim
let python_highlight_all = 1

" ref.vim"{{{
let bundle = neobundle#get('vim-ref')
function! bundle.hooks.on_source(bundle)
  let g:ref_use_vimproc = 1
  " if s:is_windows
  "   let g:ref_refe_encoding = 'cp932'
  " else
  "   let g:ref_refe_encoding = 'euc-jp'
  " endif
  "
  " " ref-lynx.
  " if s:is_windows
  "   let lynx = 'C:/lynx/lynx.exe'
  "   let cfg  = 'C:/lynx/lynx.cfg'
  "   let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
  "   let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
  " endif
  "
  " let g:ref_lynx_use_cache = 1
  " let g:ref_lynx_start_linenumber = 0 " Skip.
  " let g:ref_lynx_hide_url_number = 0

  " let g:ref_open = 'tabnew'
  let g:ref_open = 'vsplit'
  let g:ref_jquery_path = $HOME . '/.vim_ref_source/jqapi/docs'
  " let g:ref_jquery_cmd = 'w3m -dump %s'
  let g:ref_javascript_path = $HOME . '/src/jsref/htdocs'
  " let g:ref_javascript_cmd = 'w3m -dump %s'
  let g:ref_auto_resize = 1
  let g:ref_wikipedia_lang = ['ja', 'en']
  let g:ref_use_cache = 1
  let g:ref_phpmanual_path = $HOME . '/.vim_ref_source/php-chunked-xhtml'
  " let g:ref_phpmanual_cmd = 'w3m -dump %s'

  "webdictサイトの設定
  let g:ref_source_webdict_sites = {
        \   'je': {
        \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
        \   },
        \   'ej': {
        \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
        \   },
        \   'wiki': {
        \     'url': 'http://ja.wikipedia.org/wiki/%s',
        \   },
        \   'alc': {
        \     'url': 'http://eow.alc.co.jp/search?q=%s',
        \   },
        \ }

  "デフォルトサイト
  let g:ref_source_webdict_sites.default = 'alc'

  "出力に対するフィルタ。最初の数行を削除
  function! g:ref_source_webdict_sites.je.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.ej.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.wiki.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
  endfunction


  autocmd MyAutoCmd FileType ref call s:ref_my_settings()
  function! s:ref_my_settings() "{{{
    " Overwrite settings.
    nmap <buffer> [Tag]t  <Plug>(ref-keyword)
    nmap <buffer> [Tag]p  <Plug>(ref-back)

    nmap <Leader>rj :<C-u>Ref webdict je<Space>
    nmap <Leader>re :<C-u>Ref webdict ej<Space>
    nmap <Leader>ra :<C-u>Ref webdict alc<Space>
  endfunction"}}}
endfunction

unlet bundle
"}}}

" vimfiler.vim"{{{
"nmap    [Space]v   <Plug>(vimfiler_switch)
nnoremap <silent>   [Space]v   :<C-u>VimFiler<CR>
nnoremap    [Space]ff   :<C-u>VimFilerExplorer<CR>

let bundle = neobundle#get('vimfiler')
function! bundle.hooks.on_source(bundle)
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_safe_mode_by_default = 0

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_detect_drives = s:is_windows ? [
        \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/', 'I:/',
        \ 'J:/', 'K:/', 'L:/', 'M:/', 'N:/'] :
        \ split(glob('/mnt/*'), '\n') + split(glob('/media/*'), '\n') +
        \ split(glob('/Users/*'), '\n')

  " %p : full path
  " %d : current directory
  " %f : filename
  " %F : filename removed extensions
  " %* : filenames
  " %# : filenames fullpath
  let g:vimfiler_sendto = {
        \ 'unzip' : 'unzip %f',
        \ 'zip' : 'zip -r %F.zip %*',
        \ 'Inkscape' : 'inkspace',
        \ 'GIMP' : 'gimp %*',
        \ 'gedit' : 'gedit',
        \ }

  if s:is_windows
    " Use trashbox.
    let g:unite_kind_file_use_trashbox = 1
  else
    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_readonly_file_icon = '✗'
    let g:vimfiler_marked_file_icon = '✓'
  endif
  " let g:vimfiler_readonly_file_icon = '[O]'

  let g:vimfiler_quick_look_command =
        \ s:is_windows ? 'maComfort.exe -ql' :
        \ s:is_mac ? 'qlmanage -p' : 'gloobus-preview'

  " Open all git managed files in current directory "{{{
  let s:git_repo_action = { 'description' : 'open all file in the git repository' }
  function! s:git_repo_action.func(candidate)
    if(system('git rev-parse --is-inside-work-tree') ==# "true\n" )
      execute 'args'
            \ join( filter(split(system('git ls-files `git rev-parse --show-cdup`'), '\n')
            \ , 'empty(v:val) || isdirectory(v:val) || filereadable(v:val)') )
    else
      echoerr 'Not a git repository!'
    endif
  endfunction "}}}
  call unite#custom_action('file', 'git_repo_files', s:git_repo_action)
  unlet s:git_repo_action

  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings() "{{{
    call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
    call vimfiler#set_execute_file('txt', 'vim')

    " Overwrite settings.
    nnoremap <silent><buffer> J
          \ <C-u>:Unite -buffer-name=files -default-action=lcd directory_mru<CR>
    " Call sendto.
    " nnoremap <buffer> - <C-u>:Unite sendto<CR>
    " setlocal cursorline

    nmap <buffer> O <Plug>(vimfiler_sync_with_another_vimfiler)
    nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
    nmap <buffer> p <Plug>(vimfiler_quick_look)
    " nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)
    nnoremap <buffer><silent><C-j>   :<C-u>wincmd w<CR>
    nnoremap <buffer><silent><C-l>   :<C-u>tabnext<CR>

    " Migemo search.
    if !empty(unite#get_filters('matcher_migemo'))
      nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
            \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
    endif

    " One key file operation.
    " nmap <buffer> c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
    " nmap <buffer> m <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_move_file)
    " nmap <buffer> d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)
  endfunction"}}}
endfunction

unlet bundle
"}}}

" lingr-vim"{{{
let g:lingr_vim_sidebar_width = 30

" Keymappings.
autocmd MyAutoCmd FileType lingr-messages call s:lingr_messages_my_settings()
autocmd MyAutoCmd FileType lingr-say call s:lingr_say_my_settings()
autocmd MyAutoCmd FileType lingr-rooms call s:lingr_looms_my_settings()

function! s:lingr_messages_my_settings() "{{{
  nmap <buffer> o <Plug>(lingr-messages-show-say-buffer)
  nunmap <buffer> s

  if s:is_windows
    " Dirty shellslash hack.
    set noshellslash

    augroup MyAutoCmd
      autocmd WinEnter,BufWinEnter <buffer> set noshellslash
      autocmd WinLeave,BufWinLeave <buffer> set shellslash
    augroup END
  endif
endfunction"}}}
function! s:lingr_say_my_settings() "{{{
  imap <buffer> <CR> <Plug>(lingr-say-insert-mode-say)
  nmap <buffer> q <Plug>(lingr-say-close)
endfunction"}}}
function! s:lingr_looms_my_settings() "{{{
  nmap <buffer> l <Plug>(lingr-rooms-select-room)
endfunction"}}}
"}}}

" j6uil.vim"{{{
let g:J6uil_display_offline  = 0
let g:J6uil_display_online   = 0
let g:J6uil_echo_presence    = 1
let g:J6uil_display_icon     = 0
let g:J6uil_display_interval = 0
let g:J6uil_updatetime       = 1000
"}}}

" surround.vim"{{{
let g:surround_no_mappings = 1
autocmd MyAutoCmd FileType * call s:define_surround_keymappings()

function! s:define_surround_keymappings()
  if !&l:modifiable
    silent! nunmap <buffer> ds
    silent! nunmap <buffer> cs
    silent! nunmap <buffer> ys
    silent! nunmap <buffer> yS
  else
    nmap <buffer>         ds   <Plug>Dsurround
    nmap <buffer>         cs   <Plug>Csurround
    nmap <buffer>         ys   <Plug>Ysurround
    nmap <buffer>         yS   <Plug>YSurround
  endif
endfunction
"}}}

" qfreplace.vim
autocmd MyAutoCmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>

" open-browser.vim"{{{
let bundle = neobundle#get('open-browser.vim')
function! bundle.hooks.on_source(bundle)
  let g:openbrowser_open_filepath_in_vim = 0
  " let g:openbrowser_browser_commands = {'open' : 'open -a Chrome {shellescape(uri)}&'}

  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
  nmap <silent> gb :exec 'silent !open -a Google\ Chrome % &'

  nmap gs <Plug>(open-browser-wwwsearch)

  nnoremap <Plug>(open-browser-wwwsearch)
        \ :<C-u>call <SID>www_search()<CR>
  function! s:www_search()
    let search_word = input('Please input search word: ', '',
          \ 'customlist,wwwsearch#cmd_wwwsearch_complete')
    if search_word != ''
      execute 'OpenBrowserSearch' escape(search_word, '"')
    endif
  endfunction
endfunction

unlet bundle
"}}}

" autodate.vim"{{{
let autodate_format = '%d %3m %Y'
let autodate_keyword_pre = 'Last \%(Change\|Modified\):'
"}}}

" Conque.vim"{{{
let g:ConqueTerm_EscKey = '<Esc>'
let g:ConqueTerm_PyVersion = 3
"}}}

" Gundo.vim
nnoremap U      :<C-u>GundoToggle<CR>

" TweetVim "{{{
nnoremap <silent> [unite]w :<C-u>Unite tweetvim<CR>
let bundle = neobundle#get('TweetVim')
function! bundle.hooks.on_source(bundle)
  autocmd MyAutoCmd FileType tweetvim call s:tweetvim_my_settings()
  function! s:tweetvim_my_settings()
    let g:tweetvim_tweet_per_page = 300
    let g:tweetvim_cache_size = 10
    let g:tweetvim_display_source = 1
    let g:tweetvim_display_time = 1
    let g:tweetvim_open_buffer_cmd = 'edit!'
    let g:tweetvim_open_say_cmd = 'botright split'
    let g:tweetvim_display_separator = 0
    let g:tweetvim_empty_separator = 0
    let g:tweetvim_footer = ''
    let g:tweetvim_display_icon = 1
    let g:tweetvim_say_insert_account = 0
    let g:tweetvim_async_post = 1
    let g:tweetvim_expand_t_co = 1
    let g:tweetvim_display_username = 1
    inoremap <silent><buffer> <C-x><C-d> <ESC>:TweetVimBitly<CR>
    nnoremap <silent><buffer> o :TweetVimSay<CR>
    nnoremap <silent><buffer> q :close<CR>
    nmap <silent><buffer> j <Plug>(accelerated_jk_gj)
  endfunction
endfunction
unlet bundle
"}}}

" Operator-replace. "{{{
nmap R <Plug>(operator-replace)
xmap R <Plug>(operator-replace)
xmap p <Plug>(operator-replace)
"}}}

" accelerated-jk "{{{
if neobundle#is_installed('accelerated-jk')
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k
endif
"}}}

" tabpagecd
autocmd MyAutoCmd TabEnter * NeoBundleSource vim-tabpagecd

" altercmd.vim{{{
let bundle = neobundle#get('vim-altercmd')
function! bundle.hooks.on_source(bundle)
  call altercmd#load()

  AlterCommand <cmdwin> u[nite] Unite
  AlterCommand u[nite] Unite
  AlterCommand <cmdwin> u[nite] Unite
  AlterCommand u[nite] Unite
  AlterCommand <cmdwin> e[dit] Edit
  AlterCommand e[dit] Edit
  AlterCommand <cmdwin> r[ead] Read
  AlterCommand r[ead] Read
  AlterCommand <cmdwin> s[ource] Source
  AlterCommand s[ource] Source
  AlterCommand <cmdwin> w[rite] Write
  AlterCommand w[rite] Write
endfunction
unlet bundle
"}}}

" switch.vim{{{
" http://www.vimninjas.com/2012/09/12/switch/
let g:variable_style_switch_definitions = [
\   {
\     'f': {
\       'foo': 'bar'
\     },
\
\     'b': {
\       'bar': 'foo'
\     },
\   }
\ ]
" nnoremap <silent> + :call switch#Switch(g:variable_style_switch_definitions)<CR>
nnoremap <silent> ! :Switch<cr>
"}}}

" vim-niceblock "{{{
" Improved visual selection.
xmap I  <Plug>(niceblock-I)
xmap A  <Plug>(niceblock-A)
"}}}

" vim-colors-solarized "{{{
let bundle = neobundle#get('vim-colors-solarized')
function! bundle.hooks.on_source(bundle)
  syntax enable
  set background=dark
  " set background=light
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  let g:solarized_dgrade=0
  let g:solarized_bold=1
  let g:solarized_underline=1
  let g:solarized_italic=1
  " let g:solarized_contrast="high"
  " let g:solarized_visibility="high"
  let g:solarized_contrast='normal'
  let g:solarized_visibility='normal'
  colorscheme solarized
  " call togglebg#map("<F5>")
endfunction
unlet bundle
"}}}

" Like A IDE :) "{{{
function! s:likeIDE()
  cd %:p:h
  VimFilerExplorer -simple
  wincmd l
  TagbarToggle
  wincmd h
  SrcExplToggle
endfunction
nnoremap <silent> <Leader>id :call <SID>likeIDE()<CR>
"}}}

" wesleyche/SrcExpl "{{{
let bundle = neobundle#get('SrcExpl')
function! bundle.hooks.on_source(bundle)
  nnoremap <silent> <Leader>sc :SrcExplToggle<CR>
  let g:SrcExpl_RefreshTime = 1
  let g:SrcExpl_UpdateTags = 1
  let g:SrcExpl_WinHeight = 10
  let g:SrcExpl_pluginList = ["__Tag_List__", "NERD_tree_1", "Source_Explorer", "*unite*", "*vimfiler* - explorer", "__Tagbar__" ]
endfunction
unlet bundle
" }}}

" majutsushi/tagbar "{{{
let bundle = neobundle#get('tagbar')
function! bundle.hooks.on_source(bundle)
  let g:tagbar_width = 35
  let g:tagbar_autoshowtag = 1
  let g:tagbar_autofocus = 1
  let g:tagbar_sort = 0
  let g:tagbar_compact = 0
  let g:tagbar_iconchars = ['▸', '▾']
  highlight TagbarScope ctermfg=5
  highlight TagbarType cterm=bold ctermfg=55
  highlight TagbarHighlight cterm=bold,underline ctermfg=1
  highlight TagbarSignature ctermfg=70
  " Ada "{{{
  let g:tagbar_type_ada = {
        \ 'ctagstype': 'ada',
        \ 'kinds' : [
        \'P:package specs',
        \'p:packages',
        \'t:type',
        \'u:subtypes',
        \'c:record type components',
        \'l:enum type literals',
        \'v:variables',
        \'f:formal parameters',
        \'n:constants',
        \'x:exceptions',
        \'R:subprogram specs',
        \'r:subprograms',
        \'K:task specs',
        \'k:tasks',
        \'O:protected data specs',
        \'o:protected data',
        \'e:entries',
        \'b:labels',
        \'i:identifiers'
        \]
        \ } "}}}
  " Coffeescript "{{{
  if executable('coffeetags')
    let g:tagbar_type_coffee = {
          \ 'ctagsbin' : 'coffeetags',
          \ 'ctagsargs' : '--include-vars',
          \ 'kinds' : [
          \ 'f:functions',
          \ 'o:object',
          \ ],
          \ 'sro' : ".",
          \ 'kind2scope' : {
          \ 'f' : 'object',
          \ 'o' : 'object',
          \ }
          \ }
  endif "}}}
  " CSS "{{{
  let g:tagbar_type_css = {
        \ 'ctagstype' : 'Css',
        \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
        \ ]
        \ } "}}}
  " Go lang "{{{
  let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ } "}}}
  " Groovy "{{{
  let g:tagbar_type_groovy = {
        \ 'ctagstype' : 'groovy',
        \ 'kinds'     : [
        \ 'p:package',
        \ 'c:class',
        \ 'i:interface',
        \ 'f:function',
        \ 'v:variables',
        \ ]
        \ } "}}}
  " Haskell "{{{
  if executable('lushtags')
    let g:tagbar_type_haskell = {
          \ 'ctagsbin' : 'lushtags',
          \ 'ctagsargs' : '--ignore-parse-error --',
          \ 'kinds' : [
          \ 'm:module:0',
          \ 'e:exports:1',
          \ 'i:imports:1',
          \ 't:declarations:0',
          \ 'd:declarations:1',
          \ 'n:declarations:1',
          \ 'f:functions:0',
          \ 'c:constructors:0'
          \ ],
          \ 'sro' : '.',
          \ 'kind2scope' : {
          \ 'd' : 'data',
          \ 'n' : 'newtype',
          \ 'c' : 'constructor',
          \ 't' : 'type'
          \ },
          \ 'scope2kind' : {
          \ 'data' : 'd',
          \ 'newtype' : 'n',
          \ 'constructor' : 'c',
          \ 'type' : 't'
          \ }
          \ }
  endif "}}}
  " Javascript "{{{
  let g:tagbar_type_javascript = {
        \ 'ctagstype' : 'js',
        \ 'kinds'     : [
        \ 'o:object',
        \ 'f:function',
        \ 'a:array',
        \ 's:string',
        \ 'b:boolean',
        \ 'n:number',
        \ 'v:variable'
        \ ]
        \ } "}}}
  " Markdown "{{{
  let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
        \ ]
        \ } "}}}
  " Php "{{{
  let g:tagbar_phpctags_bin = $HOME . '/src/phpctags/phpctags'
  let g:tagbar_phpctags_memory_limit = '512M'
  "}}}
  " Ruby "{{{
  let g:tagbar_type_ruby = {
        \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
        \ ]
        \ } "}}}
  " Scala "{{{
  let g:tagbar_type_scala = {
        \ 'ctagstype' : 'Scala',
        \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
        \ ]
        \ } "}}}
  " Xquery "{{{
  let g:tagbar_type_xquery = {
        \ 'ctagstype' : 'xquery',
        \ 'kinds'     : [
        \ 'f:function',
        \ 'v:variable',
        \ 'm:module',
        \ ]
        \ } "}}}
  " VHDL "{{{
  let g:tagbar_type_vhdl = {
        \ 'ctagstype': 'vhdl',
        \ 'kinds' : [
        \'d:prototypes',
        \'b:package bodies',
        \'e:entities',
        \'a:architectures',
        \'t:types',
        \'p:processes',
        \'f:functions',
        \'r:procedures',
        \'c:constants',
        \'T:subtypes',
        \'r:records',
        \'C:components',
        \'P:packages',
        \'l:locals'
        \]
        \ } "}}}
endfunction
unlet bundle
"}}}

" mattn/gist-vim "{{{
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:github_user = 'h17u'
"}}}

" spolu/dwm.vim "{{{
let bundle = neobundle#get('dwm.vim')
function! bundle.hooks.on_source(bundle)
  let g:dwm_map_keys = 0
  nmap <C-n> <Plug>DWMNew
  nmap <C-c> <Plug>DWMClose
  nmap <C-@> <Plug>DWMFocus
  nmap <C-Space> <Plug>DWMFocus
endfunction
unlet bundle
"}}}

" scrooloose/syntastic "{{{
let bundle = neobundle#get('syntastic')
function! bundle.hooks.on_source(bundle)
  let g:syntastic_mode_map = { 'mode': 'active',
        \ 'active_filetypes': ['javascript'],
        \ 'passive_filetypes': ['html']
        \}
  let g:syntastic_auto_loc_list = 2
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
endfunction
unlet bundle
"}}}

" Fugitive {{{
nnoremap [Space]gd :<C-u>Gdiff<Enter>
nnoremap [Space]gs :<C-u>Gstatus<Enter>
nnoremap [Space]gl :<C-u>Glog<Enter>
nnoremap [Space]ga :<C-u>Gwrite<Enter>
nnoremap [Space]gc :<C-u>Gcommit<Enter>
nnoremap [Space]gC :<C-u>Git commit --amend<Enter>
nnoremap [Space]gb :<C-u>Gblame<Enter>
" }}}

" Memolist {{{
let bundle = neobundle#get('memolist.vim')
function! bundle.hooks.on_source(bundle)
  let g:memolist_path = $HOME . '/.vim_memo'
  let g:memolist_memo_suffix = "md"
  let g:memolist_memo_date = "%Y-%m-%d %H:%M"
  let g:memolist_prompt_tags = 1
  let g:memolist_prompt_categories = 1
  let g:memolist_qfixgrep = 0
  let g:memolist_vimfiler = 1
  let g:memolist_filename_prefix_none = 1
  command! -nargs=0 MemoGrep2 :Unite grep:~/.vim_memo -buffer-name=search -auto-preview -no-quit -resume
  nnoremap [Space]mn  :MemoNew<CR>
  nnoremap [Space]ml  :MemoList<CR>
  nnoremap [Space]mg  :MemoGrep2<CR>
endfunction

unlet bundle
"}}}

" vim-easymotion {{{
let bundle = neobundle#get('vim-easymotion')
function! bundle.hooks.on_source(bundle)
  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvb'
  let g:EasyMotion_leader_key="f"
  let g:EasyMotion_grouping=1
  highlight link EasyMotionTarget ErrorMsg
  highlight link EasyMotionShade  Comment
endfunction

unlet bundle
"}}}

" visualmark.vim {{{
let bundle = neobundle#get('visualmark.vim')
function! bundle.hooks.on_source(bundle)
  nmap <silent>em  <Plug>Vm_toggle_sign
  nmap <silent>ej  <Plug>Vm_goto_next_sign
  nmap <silent>ek  <Plug>Vm_goto_prev_sign
endfunction

unlet bundle
"}}}

" jscomplete-vim {{{
let bundle = neobundle#get('jscomplete-vim')
function! bundle.hooks.on_source(bundle)
  let g:jscomplete_use = ['dom', 'moz', 'es6th']
endfunction

unlet bundle
"}}}

" vim-nodejs-complete {{{
let bundle = neobundle#get('vim-nodejs-complete')
function! bundle.hooks.on_source(bundle)
  let g:node_usejscomplete = 1
  let g:nodejs_complete_config = {
        \  'js_compl_fn': 'jscomplete#CompleteJS',
        \  'max_node_compl_len': 25
        \}
endfunction

unlet bundle
"}}}

" othree/javascript-libraries-syntax.vim {{{
let bundle = neobundle#get('javascript-libraries-syntax.vim')
function! bundle.hooks.on_source(bundle)
  let g:used_javascript_libs = 'jquery,underscore,backbone,prelude,angularjs,requirejs'
endfunction

unlet bundle
"}}}

" davidoc/taskpaper.vim {{{
let bundle = neobundle#get('taskpaper.vim')
function! bundle.hooks.on_source(bundle)
  autocmd MyAutoCmd FileType taskpaper call s:taskpaper_my_settings()
  function! s:taskpaper_my_settings()
    let g:task_paper_date_format = "%Y-%m-%dT%H:%M"
    let g:task_paper_archive_project = "Archive"
    let g:task_paper_follow_move = 0
    let g:task_paper_search_hide_done = 1
    let g:task_paper_styles={'wait': 'ctermfg=Blue guifg=Blue', 'FAIL': 'ctermbg=Red guibg=Red'}
    " nnoremap <buffer> <silent> <Leader>tn :<C-u>call taskpaper#add_tag('next', '')<CR>
    " nnoremap <buffer> <silent> <Leader>tN :<C-u>call taskpaper#delete_tag('next', '')<CR>
    nnoremap <buffer> <silent> <Leader>tn :<C-u>call taskpaper#toggle_tag('next', '')<CR>
    nnoremap <buffer> <silent> <Leader>tw :<C-u>call taskpaper#toggle_tag('wait', '')<CR>
    " nnoremap <buffer> <silent> <Leader>tq :<C-u>call taskpaper#add_tag('priority')<CR>
    " nnoremap <buffer> <silent> <Leader>tQ :<C-u>call taskpaper#delete_tag('priority', '')<CR>
    " nnoremap <buffer> <silent> <Leader>tQ :<C-u>call taskpaper#delete_tag('priority', '1')<CR>
    nnoremap <buffer> <silent> <Leader>tq :<C-u>call taskpaper#toggle_tag('priority')<CR>
    " nnoremap <buffer> <silent> <Leader>tq :<C-u>call taskpaper#update_tag('priority')<CR>
  endfunction
endfunction

unlet bundle
"}}}

" bling/vim-airline {{{
let bundle = neobundle#get('vim-airline')
function! bundle.hooks.on_source(bundle)
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_branch_prefix = '⭠'
  let g:airline_readonly_symbol = '⭤'
  let g:airline_linecolumn_prefix = '⭡'
  let g:airline_paste_symbol = 'ρ'
  " let g:airline_left_sep='>'
  " let g:airline_right_sep='<'
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=1
  let g:airline_enable_tagbar=1
  let g:airline_detect_modified=1
  let g:airline_detect_paste=1
  let g:airline_detect_iminsert=1
  let g:airline_detect_whitespace=1
  let g:airline_theme='dark'
  let g:airline_powerline_fonts=0
  let g:airline_mode_map = {}
  let g:airline_exclude_filenames = []
  let g:airline_exclude_filetypes = []
  let g:airline_exclude_preview = 0
endfunction

unlet bundle
"}}}

" osyo-manga/vim-anzu {{{
let bundle = neobundle#get('vim-anzu')
function! bundle.hooks.on_source(bundle)
  nmap n nzz<Plug>(anzu-update-search-status)
  nmap N Nzz<Plug>(anzu-update-search-status)
  nmap * <Plug>(anzu-star)
  nmap # <Plug>(anzu-sharp)
endfunction

unlet bundle
"}}}

"}}}

"---------------------------------------------------------------------------
" Key Mappings: "{{{
"

" Use <C-Space>.
map <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" Visual mode keymappings: "{{{
" <TAB>: indent.
" xnoremap <TAB>  >
" <S-TAB>: unindent.
" xnoremap <S-TAB>  <

" Indent
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" Continuous move block in visualmode {{{
" http://maarui.doorblog.jp/archives/7530764.html
" http://d.hatena.ne.jp/tacahiroy/20120926/1348669837
function! s:move_block(d) range
  let cnt = a:lastline - a:firstline

  if a:d ==# 'u'
    let sign = '-'
    let cnt = 2
  else
    let sign = '+'
    let cnt += 1
  endif

  execute printf('%d,%dmove%s%d', a:firstline, a:lastline, sign, cnt)
endfunction

vnoremap <C-n> :call <SID>move_block('d')<Cr>==gv
vnoremap <C-p> :call <SID>move_block('u')<Cr>==gv
"}}}

" xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
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

" H, D: delete camlcasemotion. "{{{
" inoremap <expr>H           <SID>camelcase_delete(0)
" inoremap <expr>D           <SID>camelcase_delete(1)
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
endfunction "}}}
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
" Toggle TagBar
nnoremap <silent> [Space]t :<C-u>TagbarToggle<CR>

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
inoremap <silent> <Leader><Leader> <Esc> :<C-u>update<CR>

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
nnoremap <silent> [Window]t  :<C-u>tabnew<CR>

" buffer navigation using tab key
nnoremap <silent><S-tab> :<c-u>bprevious<CR>
nnoremap <silent><tab>   :<c-u>bnext<CR>

" Window and tab navigation using c-hjkl key
nnoremap <silent><C-j>   :<C-u>wincmd w<CR>
nnoremap <silent><C-k>   :<C-u>wincmd W<CR>
nnoremap <silent><C-h>   :<C-u>tabprevious<CR>
nnoremap <silent><C-l>   :<C-u>tabnext<CR>

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" A .vimrc snippet that allows you to move around windows beyond tabs "{{{
" nnoremap <silent> <Tab> :call <SID>NextWindow()<CR>
" nnoremap <silent> <S-Tab> :call <SID>PreviousWindowOrTab()<CR>

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
"}}}
nnoremap <silent> [Window]<Space>  :<C-u>call <SID>ToggleSplit()<CR>
" If window isn't splited, split buffer. "{{{
function! s:ToggleSplit()
  let prev_name = winnr()
  silent! wincmd w
  if prev_name == winnr()
    SplitNicely
  else
    call s:smart_close()
  endif
endfunction
"}}}
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

" JunkFile "{{{
" nnoremap <silent> [Window]e  :<C-u>JunkfileOpen<CR>
nnoremap <silent> [Window]ee  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
command! -nargs=0 JunkFileGrep :Unite grep:~/.vim_junk -buffer-name=search -auto-preview -no-quit -resume
nnoremap <silent> [Window]eg  :<C-u>JunkFileGrep<CR>
command! -nargs=0 JunkfileDiary call junkfile#open_immediately(
      \ strftime('%Y-%m-%d.md'))
"}}}
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

" q: Quickfix  "{{{

" The prefix key.
nnoremap [Quickfix]   <Nop>
nmap    F  [Quickfix]
" Disable Ex-mode.
nnoremap Q  q

" Toggle quickfix window.
nnoremap <silent> [Quickfix]<Space>
      \ :<C-u>call <SID>toggle_quickfix_window()<CR>
function! s:toggle_quickfix_window() "{{{
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    copen
    setlocal nowrap
    setlocal whichwrap=b,s
  endif
endfunction
"}}}

nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

"}}}

" Jump mark can restore column."{{{
nnoremap \  `
" Useless command.
nnoremap M  m
"}}}

" Smart <C-f>, <C-b>.
nnoremap <silent> <C-f> <C-f>
nnoremap <silent> <C-b> <C-b>

" Disable ZZ.
nnoremap ZZ  <Nop>

" Like gv, but select the last changed text.
nnoremap gc  `[v`]
" Specify the last changed text as {motion}.
vnoremap <silent> gc  :<C-u>normal gc<CR>
onoremap <silent> gc  :<C-u>normal gc<CR>

" Auto escape / and ? in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

" Smart }."{{{
nnoremap <silent> } :<C-u>call ForwardParagraph()<CR>
onoremap <silent> } :<C-u>call ForwardParagraph()<CR>
xnoremap <silent> } <Esc>:<C-u>call ForwardParagraph()<CR>mzgv`z
function! ForwardParagraph()
  let cnt = v:count ? v:count : 1
  let i = 0
  while i < cnt
    if !search('^\s*\n.*\S','W')
      normal! G$
      return
    endif
    let i = i + 1
  endwhile
endfunction
"}}}

" Smart home and smart end."{{{
nnoremap <silent> gh  :<C-u>call SmartHome('n')<CR>
nnoremap <silent> gl  :<C-u>call SmartEnd('n')<CR>
xnoremap <silent> gh  <ESC>:<C-u>call SmartHome('v')<CR>
xnoremap <silent> gl  <ESC>:<C-u>call SmartEnd('v')<CR>
" Smart home function"{{{
function! SmartHome(mode)
  let curcol = col('.')

  if &wrap
    normal! g^
  else
    normal! ^
  endif
  if col('.') == curcol
    if &wrap
      normal! g0
    else
      normal! 0
    endif
  endif

  if a:mode == "v"
    normal! msgv`s
  endif

  return ""
endfunction"}}}

" Smart end function"{{{
function! SmartEnd(mode)
  let curcol = col('.')
  let lastcol = a:mode ==# 'i' ? col('$') : col('$') - 1

  " Gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call cursor(0, curcol + 1)
  endif

  if curcol < lastcol
    if &wrap
      normal! g$
    else
      normal! $
    endif
  else
    normal! g_
  endif

  " Correct edit mode cursor position, put after current character
  if a:mode == "i"
    call cursor(0, col(".") + 1)
  endif

  if a:mode == "v"
    normal! msgv`s
  endif

  return ""
endfunction "}}}
"}}}

" Jump to a line and the line of before and after of the same indent."{{{
" Useful for Python.
nnoremap <silent> g{ :<C-u>call search('^' .
      \ matchstr(getline(line('.') + 1), '\(\s*\)') .'\S', 'b')<CR>^
nnoremap <silent> g} :<C-u>call search('^' .
      \ matchstr(getline(line('.')), '\(\s*\)') .'\S')<CR>^
"}}}

" Select rectangle.
xnoremap r <C-v>
" Select until end of current line in visual mode.
xnoremap v $h

" Paste next line.
nnoremap <silent> gp o<ESC>p^
nnoremap <silent> gP O<ESC>P^
xnoremap <silent> gp o<ESC>p^
xnoremap <silent> gP O<ESC>P^

" Folding."{{{
" If press h on head, fold close.
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" If press l on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press h on head, range fold close.
" xnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" If press l on fold, range fold open.
" xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
" noremap [Space]j zj
" noremap [Space]k zk
" noremap [Space]h zc
" noremap [Space]l zo
" noremap [Space]a za
" noremap [Space]m zM
" noremap [Space]i zMzv
" noremap [Space]rr zR
" noremap [Space]f zf
" noremap [Space]d zd
" noremap [Space]u :<C-u>Unite outline:foldings<CR>
"}}}

" Substitute.
xnoremap s :s//g<Left><Left>

" Easy escape."{{{
inoremap jj           <ESC>
" inoremap <expr> j       getline('.')[col('.') - 2] ==# 'j' ? "\<BS>\<ESC>" : 'j'
cnoremap <expr> j       getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
onoremap jj           <ESC>

inoremap j<Space>     j
onoremap j<Space>     j
"}}}

" Execute countable 'n.'.
" EXAMPLE: 3@n
let @n='n.'

" a>, i], etc... "{{{
" <angle>
onoremap aa  a>
xnoremap aa  a>
onoremap ia  i>
xnoremap ia  i>

" [rectangle]
onoremap ar  a]
xnoremap ar  a]
onoremap ir  i]
xnoremap ir  i]

" 'quote'
onoremap aq  a'
xnoremap aq  a'
onoremap iq  i'
xnoremap iq  i'

" "double quote"
onoremap ad  a"
xnoremap ad  a"
onoremap id  i"
xnoremap id  i"
"}}}

" Move to top/center/bottom.
noremap <expr> ZZ (winline() == (winheight(0)+1)/ 2) ?
      \ 'zt' : (winline() == 1)? 'zb' : 'zz'

" Capitalize.
nnoremap gu gUiw`]
inoremap <C-q> <ESC>gUiw`]a

" Clear highlight.
nmap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><Plug>(anzu-clear-search-status)

" operator-html-escape.vim
nmap <Leader>h <Plug>(operator-html-escape)
xmap <Leader>h <Plug>(operator-html-escape)

" Easily macro.
nnoremap @@ @a

" Improved increment. "{{{
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num)
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num != ''
    let next_num = matchstr(next_line, '^\d\+')
    let new_line = prev_line[: -len(prev_num)-1] .
          \ printf('%0'.len(prev_num . next_num).'d',
          \    max([0, prev_num . next_num + a:num])) . next_line[len(next_num):]
  else
    let new_line = prev_line . substitute(next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif

  if getline('.') !=# new_line
    call setline('.', new_line)
  endif
endfunction "}}}

" Syntax check.
nnoremap <silent> [Window]y
      \ :<C-u>echo map(synstack(line('.'), col('.')),
      \     'synIDattr(v:val, "name")')<CR>

" Swap tjump
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" git-diff-aware version of gf commands. "{{{
" http://labs.timedia.co.jp/2011/04/git-diff-aware-gf-commands-for-vim.html
" nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
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
" TODO
nnoremap gf :tabedit <cfile><CR>
vnoremap gf :tabedit <cfile><CR>
" }}}

" ヤンク、切り取り時にレジスタ"の値をzにもコピーしておく(連続貼付可に使う)
vnoremap <silent> y y:let @z=@"<CR>
vnoremap <silent> d d:let @z=@"<CR>
" ビジュアルモードで選択したテキストを消してレジスタzの内容を貼付ける(連続貼付可)
vnoremap <silent> p x"zP

" Write if buffer is edited
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>
"}}}

"---------------------------------------------------------------------------
" Commands:"{{{
"
" Toggle options. "{{{
function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction  "}}}
" Toggle variables. "{{{
function! ToggleVariable(variable_name)
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction  "}}}

" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

" :HighlightWith {filetype} ['a 'b]  XXX: Don't work in some case."{{{
command! -nargs=+ -range=% HighlightWith <line1>,<line2>call s:highlight_with(<q-args>)
" xnoremap [Space]h q:HighlightWith<Space>

function! s:highlight_with(args) range
  if a:firstline == 1 && a:lastline == line('$')
    return
  endif
  let c = get(b:, 'highlight_count', 0)
  let ft = matchstr(a:args, '^\w\+')
  if globpath(&rtp, 'syntax/' . ft . '.vim') == ''
    return
  endif
  unlet! b:current_syntax
  let save_isk= &l:isk  " For scheme.
  execute printf('syntax include @highlightWith%d syntax/%s.vim',
        \              c, ft)
  let &l:isk= save_isk
  execute printf('syntax region highlightWith%d start=/\%%%dl/ end=/\%%%dl$/ '
        \            . 'contains=@highlightWith%d',
        \             c, a:firstline, a:lastline, c)
  let b:highlight_count = c + 1
endfunction"}}}

" For git update in current directory. "{{{
command! GitPullAll call s:git_pull_all()
function! s:git_pull_all()
  let current_dir = getcwd()
  let cnt = 1
  let dirs = map(split(glob('*/.git'), '\n'), 'fnamemodify(v:val, ":p:h:h")')
  let max = len(dirs)

  for dir in filter(dirs, "
      \ glob(v:val.'/*/*.vim') != '' ||
      \ glob(v:val.'/*/*/*.vim') != '' ||
      \ glob(v:val.'/*/*/*/*.vim') != ''")
    lcd `=dir`
    redraw!

    echo printf('%d/%d git pull in %s', cnt, max, dir)

    let output = vimproc#system('git pull --rebase')
    if vimproc#get_last_status()
      echohl WarningMsg | echomsg output | echohl None
    endif

    let cnt += 1
  endfor

  echo 'Done!'

  lcd `=current_dir`
endfunction "}}}

" http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

"}}}

"---------------------------------------------------------------------------
" Functions:"{{{
"
function! s:strchars(str)
  return len(substitute(a:str, '.', 'x', 'g'))
endfunction

function! s:strwidthpart(str, width)
  if a:width <= 0
    return ''
  endif
  let ret = a:str
  let width = s:wcswidth(a:str)
  while width > a:width
    let char = matchstr(ret, '.$')
    let ret = ret[: -1 - len(char)]
    let width -= s:wcswidth(char)
  endwhile

  return ret
endfunction
function! s:strwidthpart_reverse(str, width)
  if a:width <= 0
    return ''
  endif
  let ret = a:str
  let width = s:wcswidth(a:str)
  while width > a:width
    let char = matchstr(ret, '^.')
    let ret = ret[len(char) :]
    let width -= s:wcswidth(char)
  endwhile

  return ret
endfunction

if v:version >= 703
  " Use builtin function.
  function! s:wcswidth(str)
    return strwidth(a:str)
  endfunction
else
  function! s:wcswidth(str)
    if a:str =~# '^[\x00-\x7f]*$'
      return strlen(a:str)
    end

    let mx_first = '^\(.\)'
    let str = a:str
    let width = 0
    while 1
      let ucs = char2nr(substitute(str, mx_first, '\1', ''))
      if ucs == 0
        break
      endif
      let width += s:_wcwidth(ucs)
      let str = substitute(str, mx_first, '', '')
    endwhile
    return width
  endfunction

  " UTF-8 only.
  function! s:_wcwidth(ucs)
    let ucs = a:ucs
    if (ucs >= 0x1100
          \  && (ucs <= 0x115f
          \  || ucs == 0x2329
          \  || ucs == 0x232a
          \  || (ucs >= 0x2e80 && ucs <= 0xa4cf
          \      && ucs != 0x303f)
          \  || (ucs >= 0xac00 && ucs <= 0xd7a3)
          \  || (ucs >= 0xf900 && ucs <= 0xfaff)
          \  || (ucs >= 0xfe30 && ucs <= 0xfe6f)
          \  || (ucs >= 0xff00 && ucs <= 0xff60)
          \  || (ucs >= 0xffe0 && ucs <= 0xffe6)
          \  || (ucs >= 0x20000 && ucs <= 0x2fffd)
          \  || (ucs >= 0x30000 && ucs <= 0x3fffd)
          \  ))
      return 2
    endif
    return 1
  endfunction
endif
"}}}

"---------------------------------------------------------------------------
" Platform Depends:"{{{
"
if s:is_windows
  " For Windows"{{{

  " In Windows, can't find exe, when $PATH isn't contained $VIM.
  if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
  endif

  " Shell settings.
  " Use NYAOS.
  "set shell=nyaos.exe
  "set shellcmdflag=-e
  "set shellpipe=\|&\ tee
  "set shellredir=>%s\ 2>&1
  "set shellxquote=\"

  " Use bash.
  "set shell=bash.exe
  "set shellcmdflag=-c
  "set shellpipe=2>&1\|\ tee
  "set shellredir=>%s\ 2>&1
  "set shellxquote=\"

  " Change colorscheme.
  " Don't override colorscheme.
  if !exists('g:colors_name') && !has('gui_running')
    colorscheme darkblue
  endif
  " Disable error messages.
  let g:CSApprox_verbose_level = 0

  " Popup color.
  hi Pmenu ctermbg=8
  hi PmenuSel ctermbg=1
  hi PmenuSbar ctermbg=0
  "}}}
else
  " For Linux"{{{
  if exists('$WINDIR')
    " Cygwin.

    " Use bash.
    set shell=bash
  else
    " Use zsh.
    set shell=zsh
  endif

  " Set path.
  let $PATH = expand('~/bin').':/usr/local/bin/:'.$PATH

  " For non GVim.
  if !has('gui_running')
    " Enable 256 color terminal.
    if !exists('$TMUX')
      set t_Co=256

      " For screen."{{{
      if &term =~ '^screen'
        augroup MyAutoCmd
          " Show filename on screen statusline.
          " But invalid 'another' screen buffer.
          autocmd BufEnter * if $WINDOW != 0 &&
                \ bufname('') !~ '[[:alnum:]]*://'
                \   | silent! exe '!echo -n "\ekv:%:t\e\\"' | endif
          " When 'mouse' isn't empty, Vim will freeze. Why?
          autocmd VimLeave * :set mouse=
        augroup END
      endif

      " For prevent bug.
      autocmd MyAutoCmd VimLeave * set term=screen
      "}}}

      set ttymouse=xterm2
    endif

    if has('gui')
      " Use CSApprox.vim
      NeoBundleSource csapprox

      " Convert colorscheme in Konsole.
      let g:CSApprox_konsole = 1
      let g:CSApprox_attr_map = {
            \ 'bold' : 'bold',
            \ 'italic' : '', 'sp' : ''
            \ }
      if !exists('g:colors_name')
        colorscheme candy
      endif
    else
      " Use guicolorscheme.vim
      NeoBundleSource vim-guicolorscheme

      autocmd MyAutoCmd VimEnter,BufAdd *
            \ if !exists('g:colors_name') | GuiColorScheme candy

      " Disable error messages.
      let g:CSApprox_verbose_level = 0
    endif

    " Change cursor shape.
    if &term =~ "xterm"
      let &t_SI = "\<Esc>]12;lightgreen\x7"
      let &t_EI = "\<Esc>]12;white\x7"
    endif
  endif
  "}}}
  if has('mac') "{{{
    " Mac の辞書.appで開く from http://qiita.com/items/6928282c5c843aad81d4
    " 引数に渡したワードを検索
    command! -nargs=1 MacDict      call system('open '.shellescape('dict://'.<q-args>))
    " カーソル下のワードを検索
    command! -nargs=0 MacDictCWord call system('open '.shellescape('dict://'.shellescape(expand('<cword>'))))
    " 辞書.app を閉じる
    command! -nargs=0 MacDictClose call system("osascript -e 'tell application \"Dictionary\" to quit'")
    " 辞書にフォーカスを当てる
    command! -nargs=0 MacDictFocus call system("osascript -e 'tell application \"Dictionary\" to activate'")
    " キーマッピング
    nnoremap <silent> <Leader>do :<C-u>MacDictCWord<CR>
    vnoremap <silent> <Leader>do :<C-u>MacDict<Space><C-r>*<CR>
    nnoremap <silent> <Leader>dc :<C-u>MacDictClose<CR>
    nnoremap <silent> <Leader>df :<C-u>MacDictFocus<CR>
  endif "}}}
endif

" Using the mouse on a terminal.
if has('mouse') "{{{
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    " I couldn't use has('mouse_sgr') :-(
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif "}}}
"}}}

"---------------------------------------------------------------------------
" Others:"{{{
"

" Enable mouse support.
set mouse=a

" If true Vim master, use English help file.
set helplang& helplang=en,ja

" Default home directory.
let t:cwd = getcwd()

call neobundle#call_hook('on_source')

if !has('vim_starting')
  if exists(':IndentLinesReset')
    IndentLinesReset
  endif
endif

set secure

"}}}

"---------------------------------------------------------------------------
" Experimental:"{{{
"



" }}}





" vim:set et ts=4 sts=2 sw=2 tw=0 fdm=marker:
" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2
