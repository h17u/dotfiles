# .zshrc

# antigen #{{{
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
    source $HOME/.zsh/antigen/antigen.zsh

    # Load the oh-my-zsh's library.
    antigen use oh-my-zsh

    # Load theme #{{{
    # antigen theme robbyrussell
    # antigen theme muse
    # antigen theme arrow
    # antigen theme cloud # short dir, git,and time in right
    # antigen theme crunch #time, rvm, git, and dir in right
    # antigen theme edvardm # short dir,git, and ruby in right
    # antigen theme essembeh # host, dir, git, no right
    # antigen theme example # basic, no right
    # antigen theme fishy # host, short dir, and git in right
    # antigen theme fletcherm #user, dir, git, and time in right
    # antigen theme gallifrey #host, dir, git, and result in right
    # antigen theme nicoulaj # git/hg in right
    antigen theme terminalparty #simple left
    # antigen theme kardan # simple left column
    # antigen theme macovsky # only left column
    # antigen theme pygmalion
    #}}}

    # Bundles from the default repo (robbyrussell's oh-my-zsh). #{{{
    # antigen bundle ant
    # antigen bundle apache2-macports
    # antigen bundle archlinux
    # antigen bundle autoenv
    antigen bundle autojump
    # antigen bundle battery
    # antigen bundle bower
    # antigen bundle brew
    # antigen bundle bundler
    # antigen bundle bwana
    # antigen bundle cabal
    # antigen bundle cake
    # antigen bundle capistrano
    # antigen bundle celery
    # antigen bundle cloudapp
    antigen bundle coffee
    # antigen bundle colemak
    antigen bundle colored-man
    # antigen bundle colorize
    # antigen bundle command-not-found
    # antigen bundle compleat
    # antigen bundle composer
    # antigen bundle copydir
    # antigen bundle copyfile
    # antigen bundle cp
    antigen bundle cpanm
    # antigen bundle debian
    # antigen bundle dircycle
    # antigen bundle dirpersist
    # antigen bundle django
    # antigen bundle emoji-clock
    # antigen bundle encode64
    antigen bundle extract
    # antigen bundle fabric
    # antigen bundle fasd
    # antigen bundle fbterm
    # antigen bundle forklift
    # antigen bundle gas
    # antigen bundle gem
    # antigen bundle git
    # antigen bundle git-extras
    # antigen bundle git-flow
    # antigen bundle git-flow-avh
    # antigen bundle git-hubflow
    # antigen bundle git-remote-branch
    # antigen bundle gitfast
    # antigen bundle github
    # antigen bundle gnu-utils
    # antigen bundle go
    antigen bundle golang
    # antigen bundle gpg-agent
    # antigen bundle gradle
    # antigen bundle grails
    # antigen bundle heroku
    # antigen bundle history
    # antigen bundle history-substring-search
    # antigen bundle jake-node
    # antigen bundle jira
    # antigen bundle jruby
    # antigen bundle kate
    # antigen bundle knife
    # antigen bundle laravel
    # antigen bundle last-working-dir
    # antigen bundle lein
    # antigen bundle lighthouse
    # antigen bundle lol
    # antigen bundle macports
    # antigen bundle mercurial
    # antigen bundle mvn
    # antigen bundle mysql-macports
    # antigen bundle nanoc
    # antigen bundle node
    # antigen bundle npm
    # antigen bundle nyan
    # antigen bundle osx
    antigen bundle pass
    # antigen bundle per-directory-history
    # antigen bundle perl
    # antigen bundle phing
    # antigen bundle pip
    # antigen bundle pj
    # antigen bundle postgres
    # antigen bundle pow
    # antigen bundle powder
    # antigen bundle powify
    # antigen bundle profiles
    # antigen bundle python
    # antigen bundle rails
    # antigen bundle rails3
    # antigen bundle rails4
    # antigen bundle rake
    # antigen bundle rand-quote
    antigen bundle rbenv
    # antigen bundle rbfu
    # antigen bundle rebar
    # antigen bundle redis-cli
    # antigen bundle repo
    # antigen bundle rsync
    # antigen bundle ruby
    # antigen bundle rvm
    # antigen bundle safe-paste
    # antigen bundle sbt
    # antigen bundle scala
    # antigen bundle screen
    # antigen bundle sprunge
    # antigen bundle ssh-agent
    # antigen bundle sublime
    # antigen bundle supervisor
    # antigen bundle suse
    # antigen bundle svn
    # antigen bundle symfony
    # antigen bundle symfony2
    # antigen bundle systemd
    # antigen bundle taskwarrior
    # antigen bundle terminalapp
    # antigen bundle terminitor
    # antigen bundle textmate
    antigen bundle themes
    # antigen bundle thor
    # antigen bundle tmux
    # antigen bundle tmuxinator
    # antigen bundle torrent
    antigen bundle urltools
    antigen bundle vagrant
    # antigen bundle vi-mode
    # antigen bundle virtualenv
    # antigen bundle virtualenvwrapper
    # antigen bundle vundle
    # antigen bundle wakeonlan
    antigen bundle web-search
    # antigen bundle yum
    # antigen bundle zeus
    antigen bundle brew-cask
    #}}}

    # Bundles othoer repo
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-completions src
    antigen bundle s7anley/zsh-geeknote
    antigen bundle motemen/ghq zsh

    # http://blog.m4i.jp/entry/2012/01/26/064329
    antigen bundle m4i/cdd
    #TODO update antigen to source file below
    if [[ -f $HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-m4i-SLASH-cdd.git/cdd ]]; then
      source $HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-m4i-SLASH-cdd.git/cdd
    fi

    # Tell antigen that you're done.
    antigen apply
fi
#}}}

# History # {{{
export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
function history-all { history -E 1 } # 全履歴の一覧を出力する
# }}}

# Prompt # {{{
# local pct=$'%0(?||%18(?||%{\e[31m%}))%#%{\e[m%}'
# export PROMPT=$'%{\e[$[32+RANDOM%5]m%}%n@%m'"$pct "
# export RPROMPT='[%39<...<%~]'
# }}}

# Set basic environment # {{{
umask 002
autoload -Uz colors && colors
autoload -Uz add-zsh-hook

export BROWSER=w3m
export EDITOR=vim
set meta-flag on set input-meta on set output-meta on set convert-meta off # for japanese
export PAGER=less
export MANPAGER="/bin/sh -c \"col -b -x | \
  vim -R -c 'set ft=man ts=8 nomod nolist nonu noma' \
  -c 'map q :q<CR>' \
  -c 'map b <C-U>' \
  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' \
  -c 'nnoremap i <nop>' \
  -\""
export GREP_OPTIONS='--color=auto'
#export LANG=ja_JP.UTF-8
#export LANG=C
export LANG=en_US.UTF-8
#export LC_CTYPE='utf-8'
export LC_CTYPE=en_US.UTF-8
unset LC_ALL
# if user is root
case ${UID} in
0)
    export LANG=C
    ;;
esac
export MANPATH=/opt/local/share/man:$MANPATH
export MANPATH=/usr/local/share/man:$MANPATH
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --RAW-CONTROL-CHARS'
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/homebrew-cask/Caskroom"
# }}}

# Set shell options # {{{
setopt auto_cd auto_name_dirs auto_pushd pushd_ignore_dups
setopt extended_history hist_ignore_dups hist_ignore_space hist_save_nodups
setopt share_history inc_append_history hist_no_store hist_verify hist_reduce_blanks
setopt prompt_subst correct list_packed nolistbeep
setopt list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt complete_aliases
setopt multibyte print_eight_bit
setopt auto_menu
setopt auto_param_slash auto_remove_slash
setopt magic_equal_subst multios brace_ccl interactive_comments
setopt ignoreeof # forces the user to type exit or logout,  instead of just pressing ^D.
# setopt extended_glob
#setopt globdots
#setopt xtrace
# }}}

# Aliases # {{{
alias cp='cp -i' mv='mv -i'
#alias ranking='sort|uniq -c|sort -nr|cat -n'
#alias df='df -h' du='du -h'
#alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias pd='pushd' po='popd'

alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias reload='exec zsh -l'
alias d='dirs -v'

alias ls='gls --color=auto --time-style=long-iso'
alias l=' ls'
alias ll=' ls -lh'
alias la=' ls -alh'
alias lr=' ls -R'
alias ld=' ls -d'
alias l1=' ls -1'
alias lt=' tree -F'
alias diff=$(brew --prefix colordiff)/bin/colordiff
alias git=hub
alias g=git
alias vi='$EDITOR'
alias lockscreen='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias screensaver='open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app'
# }}}

# Global aliases {{{
#
# 標準出力を表示しない
alias -g NL='> /dev/null'
# 標準出力/標準エラー出力を表示しない
alias -g NLL='> /dev/null 2>&1'
# 標準出力を標準エラー出力へ
alias -g ER='1>&2'

alias -g TELLME="&& say succeeded || say failed"
alias -g G="| grep"
alias -g L='| $PAGER'
# alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sed'
alias -g V="| vim -R -"
alias -g U=' --help | head'
alias -g P=' --help | less'
alias -g E=' --help | $PAGER'
alias -g B='`git branch | peco | sed -e "s/^\*[ ]*//g"`'
alias -g W='| w3m -T text/html'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# }}}

# Replace rm with trash # {{{
# https://github.com/rcmdnk/scripts/raw/master/trash.sh
alias rm='~/bin/trash.sh >/dev/null 2>&1'
alias rr='~/bin/trash.sh -rf >/dev/null 2>&1'
alias trash='~/bin/trash.sh'
export TRASHLIST=~/.trashlist
export TRASHBOX=~/.Trash
export MAXTRASHBOXSIZE=4096
export MAXTRASHSIZE=`echo $MAXTRASHBOXSIZE "*" 0.1|bc -l|cut -d. -f1`
# }}}

# Enable visual-mode like vim # {{{
# http://zshscreenvimvimpwget.blog27.fc2.com/blog-entry-3.html
source $HOME/.zsh/zsh_vim_visualmode/vim_visualmode.plugin.zsh
# }}}

### zmv {{{
#
#   簡単に複数ファイルのリネームが可能
#   http://d.hatena.ne.jp/mollifier/20101227/p1
#
#     noglob *などのパス展開を行わない(""で''で囲わなくても良い)
#     -n 確認内容を出力
#     -C mvの代わりにcpを実行
#     -L mvの代わりにlnを実行
#
#     -w $ noglob zmv -w hoge-*.*.*.tar.gz hoge-$1--$2--$3.tar.gz
#     -W $ noglob zmv -W hoge-*.*.*.tar.gz hoge-*--*--*.tar.gz
#
#     ゼロパティング
#     $ (n=1; zmv -n '*.jpg' '${(l:3::0:)$((n++))}.jpg')
#
#     変数フラグ U:大文字 L:小文字 C:キャピタルケース
#     $ zmv '(*).txt' '${(U)1}.txt'
#
#     変数置換 ${1//pattern/repl} ## は1回以上の繰り返し
#     $ zmv '(*)' '${1// /_}'
#     $ zmv '(*)' '${1// ##/_}'
#
#     バックアップ
#     $ noglob zmv -W -C '(*.c)' '$1.bak'
#
#     シンボリックリンク作成
#     $ noglob zmv -w -L -s 'dotfiles/.(*)' '.$1'
#
#     再帰変換
#     $ zmv '(**/)makefile' '$1Makefile'
#
#     末尾の.tmpを消す
#     $ zmvW .*.tmp .*
#
#     ヘルプ
#     $ man zshcontrib
#     $ man zsh-lovers
#
#
autoload -Uz zmv
alias zmv="noglob zmv"
alias zmvn="zmv -n"
alias zmvw="zmv -w"
alias zmvW="zmv -W"

# }}}

# run-help # {{{
# http://qiita.com/items/81a9daf716d94b63f94f
alias run-help >/dev/null 2>&1 && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn
# }}}

# Completion # {{{
# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh
# https://github.com/yonchu/dotfiles/blob/master/.zsh/.zshrc
fpath=(~/.zsh/completions(N-/) ${fpath})
autoload -Uz compinit && compinit -u -d ~/.zcompdump
autoload -Uz bashcompinit && bashcompinit
source /usr/local/etc/bash_completion.d/tig-completion.bash
#autoload -Uz vcs_info
#autoload -Uz promptinit && promptinit
#autoload -Uz predict-on && predict-on

# Options # {{{
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.
# }}}

# 補完キャッシュの設定 # {{{
# 一部のコマンドライン定義は、展開時に時間のかかる処理を行う
# apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perlの-Mオプション,
# bogofilter (zsh 4.2.1以降), fink, mac_apps (MacOS X)(zsh 4.2.2以降)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache
# Use caching to make completion for cammands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
# }}}

# Case-insensitive (all), partial-word, and then substring completion. # {{{
if zstyle -t ':prezto:module:completion:*' case-sensitive; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  setopt CASE_GLOB
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unsetopt CASE_GLOB
fi
# }}}

# 補完方法毎にグループ化し、グループ名に説明を付加 # {{{
#  %F...%f : カラー
#  %B...%b : 太字
#  %U...%u : 下線
#  %d      : 補完候補の説明(ラベル)
# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
# }}}

# 補完方法の設定:指定した順番に実行 # {{{
#  _oldlist 前回の補完結果を再利用
#  _complete: 補完
#  _match: globを展開しないで候補の一覧から補完
#  _history: ヒストリのコマンドから補完
#  _ignored: 補完候補にださないと指定したものもから補完
#  _approximate: 似ている候補を補完
#  _correct: 綴り修正(入力を終えた部分のみ修正)
#  _prefix: カーソル以降を無視してカーソル位置までで補完
#  _list, expand, etc
# Fuzzy match mistyped completions.
zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# }}}

# sudo用pathを設定 # {{{
# typeset -T は重複実行できないため一度環境変数を削除する
# (Reloadで失敗しないようにするため)
unset SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
export SUDO_PATH
# sudo時の補完対象の設定
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
# }}}

# 補完候補がない場合の曖昧検索 # {{{
#  m:{a-z}={A-Z}: 大文字小文字無視
#  r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' '+m:{A-Z}={a-z}'
# }}}

# 変数の添字補完
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# 補完を無視する対象 # {{{
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# }}}

# cd # {{{
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補にする
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# 親ディレクトリから補完時にカレントディレクトリ表示しない (e.g. cd ../<TAB>):
zstyle ':completion:*:*:cd:*' ignore-parents parent pwd ..
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
# }}}

# 重複パスを登録しない
typeset -U cdpath
cdpath=($HOME{,/links}(N-/))

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories # {{{
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
# }}}

# History # {{{
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
# }}}

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion. # {{{
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
compdef mosh=ssh
# }}}

# Don't complete uninteresting users... # {{{
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show
# }}}

# Ignore multiple entries. # {{{
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
# }}}

# Kill # {{{
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# }}}

# Man # {{{
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# }}}

# Media Players # {{{
zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'
# }}}

# Mutt # {{{
if [[ -s "$HOME/.mutt/aliases" ]]; then
  zstyle ':completion:*:*:mutt:*' menu yes select
  zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
fi
# }}}

# SSH/SCP/RSYNC # {{{
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
# }}}

## cdr <TAB> (最近移動したディレクトリ履歴からcd) # {{{
autoload -U chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file ~/.chpwd-recent-dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":completion:*" recent-dirs-insert both
zstyle ":completion:*:*:cdr:*:*" menu select=2
# }}}

# grunt # {{{
zstyle ':completion::complete:grunt::options:' show_grunt_path yes
zstyle ':completion::complete:grunt::options:' expire 1
# }}}

# LS_COLORS # {{{
# http://qiita.com/items/84fa4e051c3325098be3
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#eval $(gdircolors ~/.dircolors/dircolors.256dark)
#eval $(gdircolors ~/.dircolors/dircolors.ansi-dark)
#eval $(gdircolors ~/.dircolors/dircolors.ansi-light)
eval $(gdircolors ~/.dircolors/dircolors.ansi-universal)
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
# }}}

# }}}

# Key bindings {{{
# bindkey -e #Emacs
bindkey -v #VIM

# emacs # {{{
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M emacs '^K' history-beginning-search-backward-end
bindkey -M emacs '^J' history-beginning-search-forward-end
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M emacs '^R' history-incremental-pattern-search-backward
# bindkey -M emacs '^S' history-incremental-pattern-search-forward
bindkey -M emacs '^U' kill-line
bindkey -M emacs '^T' forward-word
bindkey -M emacs '^G' backward-word
bindkey -M emacs '^C' send-break
bindkey -M emacs '^X^U' undo
bindkey -M emacs '^X^R' redo

# Change keybind to vicmd like vim easy jj escape
bindkey -M emacs -s 'jj' '^x^v'
# }}}

# vicmd # {{{
bindkey -M viins '^K' history-beginning-search-backward
bindkey -M viins '^J' history-beginning-search-forward
bindkey -M viins '^P' history-substring-search-up
bindkey -M viins '^N' history-substring-search-down
bindkey -M viins '^R' history-incremental-pattern-search-backward
# bindkey -M viins '^S' history-incremental-pattern-search-forward
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^C' send-break
bindkey -M vicmd 'k' vi-up-line-or-history
bindkey -M vicmd 'j' vi-down-line-or-history
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo
bindkey -M vicmd 'K' run-help

# Change keybind to vicmd like vim easy jj escape
bindkey -M viins -s 'jj' '^['
# }}}

# like insert-last-word, except that non-words are ignored # {{{
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey -M emacs '^]' insert-last-word
bindkey -M viins '^]' insert-last-word
bindkey -M vicmd '^]' insert-last-word
# }}}

# kill backward one word, # {{{
# where a word is defined as a series of non-blank characters
function _kill-backward-blank-word() {
    zle set-mark-command
    zle vi-backward-blank-word
    zle kill-region
}
zle -N _kill-backward-blank-word
bindkey -M emacs '^S' _kill-backward-blank-word
bindkey -M viins '^S' _kill-backward-blank-word
# }}}

# quote previous word in single or double quote # {{{
autoload -Uz modify-current-argument
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey -M emacs '^[s' _quote-previous-word-in-single
bindkey -M vicmd '^X^S' _quote-previous-word-in-single

_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey -M emacs '^[d' _quote-previous-word-in-double
bindkey -M vicmd '^X^D' _quote-previous-word-in-double
# }}}

# quote URL # {{{
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
# }}}

# Edit the command line using your visual editor # {{{
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs '^Xe' edit-command-line
bindkey -M emacs '^X^E' edit-command-line
bindkey -M vicmd '^X^E' edit-command-line
# }}}

# back-wordでの単語境界の設定 # {{{
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /@*?_-.[]~=&;!#$%^(){}<>"
zstyle ':zle:*' word-style unspecified
WORDCHARS=' /@*?_-.[]~=&;!#$%^(){}<>'
# }}}

# Command Line Stack の改良版 # {{{
push_line_and_show_buffer_stack() {
    POSTDISPLAY="
stack: $BUFFER"
    zle push-line-or-edit
}
zle -N push_line_and_show_buffer_stack
bindkey -M emacs '^[Q' push_line_and_show_buffer_stack
bindkey -M vicmd 'q' push_line_and_show_buffer_stack
# }}}

# foreground-vi # {{{
# http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html
foreground-vi() {
  fg %$ED
}
zle -N foreground-vi
bindkey '^Z' foreground-vi
# }}}

# C-x, C-pでコマンドをクリップボードにコピーする #{{{
# http://d.hatena.ne.jp/hiboma/20120315/1331821642
function pbcopy-buffer() {
  print -rn $BUFFER | pbcopy
  zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey -M emacs '^X^P' pbcopy-buffer
bindkey -M viins '^X^P' pbcopy-buffer
bindkey -M vicmd '^X^P' pbcopy-buffer
# }}}

# ls by enter key if buffer is null # {{{
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb 2> /dev/null
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey -M emacs '^M' do_enter
bindkey -M viins '^M' do_enter
bindkey -M vicmd '^M' do_enter
# }}}

# menuselect # {{{
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# }}}

# }}}

# Functions {{{
function google() { #{{{
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.com/$opt
} #}}}

function alc() { #{{{
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?ref=crx'
    opt="${opt}&q=${str}"
  fi
  w3m http://eow.alc.co.jp/$opt
} #}}}

# Complete word from tmux pane # {{{
# http://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html
_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
# }}}

## man zshall # {{{
# zman [search word]
function zman() {
    if [[ -n $1 ]]; then
        PAGER="less -g -s '+/"$1"'" man zshall
        echo "Search word: $1"
    else
        man zshall
    fi
} # }}}

# zsh 用語検索 # {{{
# http://qiita.com/mollifier/items/14bbea7503910300b3ba
function zwman() {
    zman "^       $1"
} # }}}

# zsh フラグ検索 # {{{
function zfman() {
    local w='^'
    w=${(r:8:)w}
    w="$w${(r:7:)1}|$w$1(\[.*\].*)|$w$1:.*:|$w$1/.*/.*"
    zman "$w"
} # }}}

# make dir named by current date # {{{
function make_date_dir_and_cd() {
    local date_dir=$(date '+%Y-%m-%d')
    if [ ! -d "$date_dir" ]; then
        mkdir "$date_dir" || return
    fi
    cd "$date_dir"
}
alias ddir='make_date_dir_and_cd'
# }}}

chpwd() { # {{{
    ls_abbrev 1>&2
    # cdd
    type _cdd_chpwd >/dev/null 2>&1 && _cdd_chpwd
} # }}}

ls_abbrev() { # {{{
  # http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059
    if [[ ! -r $PWD ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always' '--group-directories-first')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
} # }}}

# kill background jobs # {{{
function kill-jobs() {
  if [ "$(jobs -p)" ]; then kill $(jobs -p); fi
}
# }}}

# copy pwd # {{{
function pwd-clip() {
    local copyToClipboard

    if which pbcopy >/dev/null 2>&1 ; then
        # Mac
        copyToClipboard='pbcopy'
    elif which xsel >/dev/null 2>&1 ; then
        # Linux
        copyToClipboard='xsel --input --clipboard'
    elif which putclip >/dev/null 2>&1 ; then
        # Cygwin
        copyToClipboard='putclip'
    else
        copyToClipboard='cat'
    fi

    # ${=VAR} enables SH_WORD_SPLIT option
    # so ${=VAR] is splited in words, for example "a" "b" "c"
    echo -n $PWD | ${=copyToClipboard}
}
# }}}

# mosh with tmux renaming window # {{{
# "gnu screen - rename tmux window name to prompt_command, ps1 or remote ssh hostname? - Super User"
# http://superuser.com/questions/249293/rename-tmux-window-name-to-prompt-command-ps1-or-remote-ssh-hostname
function mosh() {
export MOSH_TITLE_NOPREFIX=1
if [ "${TMUX}" ]; then
  tmux rename-window "$1"
  command mosh "$@"
  tmux set-window-option automatic-rename "on" 1>/dev/null
else
  command mosh "$@"
fi
}
# }}}

# }}}

# Peco {{{

# Select zsh history {{{
function peco-select-history() {
local tac
if which tac > /dev/null; then
  tac="tac"
else
  tac="tail -r"
fi
BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
CURSOR=$#BUFFER
zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
# }}}

# Select ghq list {{{
function peco-src () {
local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
if [ -n "$selected_dir" ]; then
  BUFFER="cd ${selected_dir}"
  zle accept-line
fi
zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
# }}}

# Kill process {{{
# http://k0kubun.hatenablog.com/entry/2014/07/06/033336
function peco-pkill() {
for pid in `ps aux | peco | awk '{ print $2 }'`
do
  kill $pid
  echo "Killed ${pid}"
done
}
alias pk="peco-pkill"
# }}}

# Search file recursively and edit {{{
function peco-search-file() {
${1:=$(pwd)}
local selected=$(find $1 -maxdepth 2 | peco)
if [[ -d $selected ]]; then
  peco-search-file $selected
elif [[ -f $selected ]]; then
  $EDITOR $selected
fi
}
# }}}

# }}}

# PATH #{{{

# My local bin directory
export PATH=$PATH:~/bin

# gnu coreutils alias
if [ "$PS1" ]; then
        export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
        export PATH=$(brew --prefix gnu-sed)/libexec/gnubin:$PATH
        export MANPATH=$(brew --prefix coreutils)/libexec/gnuman:$MANPATH
        export MANPATH=$(brew --prefix gnu-sed)/libexec/gnuman:$MANPATH
fi

# anyenv
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  if [ -n "$TMUX" ]; then
    eval "$(anyenv init -)"
  fi
fi

# Amazon EC2 Command-Line Tools
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

# Heroku Toolbelt
export PATH=$PATH:/usr/local/heroku/bin

# Go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Remove duplicate $PATH entries
# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command
export PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
export MANPATH=`echo -n $MANPATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
export NODE_PATH=`echo -n $NODE_PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
#typeset -U path cdpath fpath manpath
# }}}

# Create and attach tmux session #{{{
case ${UID} in
0)
    ;;
*)
    # iTerm2
    if [ "${TERM_PROGRAM}" = 'iTerm.app' ]; then
        ~/bin/tmux_open_windows.sh 2>&1
    fi
esac #}}}

# tmuxinator # {{{
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
# }}}

# Update tmux status line # {{{
function zle-keymap-select zle-line-init zle-line-finish {
vimode="${${KEYMAP/vicmd/n}/(main|viins)/i}"

# update prompt
case $KEYMAP in # {{{
  vicmd)
    PROMPT="[%{$fg_bold[cyan]%}$vimode%{$reset_color%}] %{$fg_bold[white]%}%%%{$reset_color%} "
    ;;
  main|viins)
    PROMPT="[%{$fg_bold[cyan]%}$vimode%{$reset_color%}] %{$fg_bold[white]%}%%%{$reset_color%} "
    ;;
esac # }}}

zle reset-prompt
zle -R

}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
# }}}


# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim:set et ts=4 sts=2 sw=2 tw=0 fdm=marker:
