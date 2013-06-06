# .zshrc

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
function history-all { history -E 1 } # 全履歴の一覧を出力する


# prompt
#### http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
local pct=$'%0(?||%18(?||%{\e[31m%}))%#%{\e[m%}'
#export PROMPT=$'%{\e[$[32+RANDOM%5]m%}%U%B%m%b'"$pct%u "
export PROMPT=$'%{\e[$[32+RANDOM%5]m%}%n@%m'"$pct "
#export PROMPT="$pct "
export RPROMPT='[%39<...<%~]' 
#export RPROMPT='[%n@%m %39<...<%~]' 
autoload colors
colors
#### http://news.mynavi.jp/column/zsh/002/
#case ${UID} in
#0)
#    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
#    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#    RPROMPT='[%39<...<%~]' 
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#    ;;
#*)
#    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
#    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
#    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#    RPROMPT='[%39<...<%~]' 
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#    ;;
#esac

export BROWSER=w3m
export EDITOR=vim
set meta-flag on set input-meta on set output-meta on set convert-meta off # for japanese
export TERM=xterm-256color
export PAGER=less
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

# Set shell options
setopt auto_cd auto_name_dirs auto_pushd pushd_ignore_dups
setopt extended_history hist_ignore_dups hist_ignore_space hist_save_nodups
setopt share_history inc_append_history hist_no_store hist_verify
setopt prompt_subst correct list_packed nolistbeep
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt complete_aliases
setopt multibyte print_eight_bit
setopt auto_menu
setopt auto_param_slash auto_remove_slash
#setopt xtrace



# Interactive operation...
alias rm='rm -i' cp='cp -i' mv='mv -i'
alias rr='command rm -rf'
#alias ranking='sort|uniq -c|sort -nr|cat -n'
#alias df='df -h' du='du -h'
#alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias pd='pushd' po='popd'


# Misc :)
#export LESS=MrXEd
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
#alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
alias ls='gls --color=auto'
#alias ls='ls -G'
#alias l='gls -lAFh --color=auto'
#alias ll='gls -lAFh --color=auto | less'
alias ll='ls -l' la='ls -al'

# Global alias
alias -g TELLME="&& say succeeded || say failed"
alias -g G="| grep"
alias -g H='| head'
alias -g L="| less -R"
alias -g W='| wc'
alias -g T='| tail'
alias -g V="| vim -R -"
alias -g U=' --help | head'
alias -g P=' --help | less'
alias -g ...='../..'
alias -g ....='../../..'


#########
# http://wiki.archlinux.org/index.php/Zsh
autoload -U compinit && compinit
#autoload -Uz vcs_info
#autoload -U promptinit && promptinit
#autoload predict-on && predict-on

#zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' list-colors ''

# LS_COLORS
# http://qiita.com/items/84fa4e051c3325098be3
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#eval $(gdircolors ~/.dircolors/dircolors.256dark)
#eval $(gdircolors ~/.dircolors/dircolors.ansi-dark)
#eval $(gdircolors ~/.dircolors/dircolors.ansi-light)
eval $(gdircolors ~/.dircolors/dircolors.ansi-universal)
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi



# key bindings
bindkey -e #Emacs
#bindkey -v #VIM
#bindkey -M emacs
#bindkey -M vicmd
#bindkey -M viins
# zle-line-init() { zle -K vicmd; } ; zle -N zle-line-init

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '\\ep' history-beginning-search-backward-end
bindkey '\\en' history-beginning-search-forward-end
bindkey -M vicmd 'q' push-line # Command line stack
#bindkey -M vicmd 'q' push-line-or-edit
#bindkey -M vicmd 'q' push-input
bindkey -M vicmd 'H' run-help
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char





# http://www.gentei.org/~yuuji/support/zsh/files/zshrc


# http://gihyo.jp/dev/serial/01/zsh-book/0003
# nprom () {
#     setopt prompt_subst
#     local rbase=$'%{\e[33m%}[%~]%{\e[m%}' lf=$'\n'
#     local pct=$'%0(?||%18(?||%{\e[31m%}))%#%{\e[m%}'
#     RPROMPT="%9(~||$rbase)"
#     case "$USER" in
#       yatex)	PROMPT=$'%{\e[33m%}%U%m{%n}%%%{\e[m%}%u ' ;;
#       java)	PROMPT=$'%{\e[36m%}%U%m{%n}%%%{\e[m%}%u ' ;;
#       *)
#     local pbase=$'%{\e[$[32+RANDOM%5]m%}%U%B%m{%n}%b'"$pct%u "
#     PROMPT="%9(~|$rbase$lf|)$pbase"
#     ;;
#     esac
#     [[ "$TERM" = "screen" ]] && RPROMPT="[%U%~%u]"
# }
# nprom


# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \ 
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end


# http://www.shell-fu.org/lister.php?id=375
# Handy Extract Program
function extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvjf $1 ;;
			*.tar.gz)	tar xvzf $1 ;;
			*.bz2)		bunzip2 $1 ;;
			*.rar)		unrar x $1 ;;
			*.gz)		gunzip $1 ;;
			*.tar)		tar xvf $1 ;;
			*.tbz2)		tar xvjf $1 ;;
			*.tgz)		tar xvzf $1　;;
			*.zip)		unzip $1 ;;
			*.Z)		uncompress $1 ;;
			*.7z)		7z x $1 ;;
			*)			echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}


# http://d.hatena.ne.jp/mollifier/20100317/p1
#if which pbcopy >/dev/null 2>&1 ; then 
#    # Mac  
#    alias -g C='| pbcopy'
#elif which xsel >/dev/null 2>&1 ; then 
#    # Linux
#    alias -g C='| xsel --input --clipboard'
#elif which putclip >/dev/null 2>&1 ; then 
#    # Cygwin 
#    alias -g C='| putclip'
#fi


# http://memo.officebrook.net/20090205.html
function google() {
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
}


function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup




# 20111202
# Setup Amazon EC2 Command-Line Tools
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

# 20120110 MacPort
#export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export PATH=/usr/local/bin:$PATH

# Use vim installed from macport
#alias vim=/opt/local/bin/vim
#alias vi=/opt/local/bin/vim
#alias view=/opt/local/bin/vim
#alias vimdiff=/opt/local/bin/vim
alias vim=$(brew --prefix vim)/bin/vim
alias vi=$(brew --prefix vim)/bin/vim
alias view=$(brew --prefix vim)/bin/vim
alias vimdiff=$(brew --prefix vim)/bin/vim

### Added by the Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

#20130306
### Added for rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"


#screen
#function ssh_screen(){
# eval server=?${$#}
# screen -t $server ssh "$@"
#}
#if [ x$TERM = xscreen ]; then
#  alias ssh=ssh_screen
#fi

# added for my local bin directory
#export PATH=$PATH:$EC2_HOME/bin
export PATH=$PATH:~/bin


# tmux自動起動
# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
# http://qiita.com/items/bd319bdaffb403d5e605
#is_screen_running() {
#    # tscreen also uses this varariable.
#    [ ! -z "$WINDOW" ]
#}
#is_tmux_runnning() {
#    [ ! -z "$TMUX" ]
#}
#is_screen_or_tmux_running() {
#    is_screen_running || is_tmux_runnning
#}
#shell_has_started_interactively() {
#    [ ! -z "$PS1" ]
#}
#resolve_alias() {
#    cmd="$1"
#    while \
#        whence "$cmd" >/dev/null 2>/dev/null \
#        && [ "$(whence "$cmd")" != "$cmd" ]
#    do
#        cmd=$(whence "$cmd")
#    done
#    echo "$cmd"
#}
#if ! is_screen_or_tmux_running && shell_has_started_interactively; then
#    #for cmd in tmux tscreen screen; do
#    for cmd in tmux tscreen screen; do
#        if whence $cmd >/dev/null 2>/dev/null; then
#            $(resolve_alias "$cmd")
#            break
#        fi
#    done
#fi

# for tmux
#zsh ~/bin/tmux.sh


# for gnu coreutils alias
#if [ "$PS1" ] && [ -f '/usr/local/Cellar/coreutils/8.12/aliases' ]; then
#        . /usr/local/Cellar/coreutils/8.12/aliases
#fi
# http://d.hatena.ne.jp/kitokitoki/20111128/p2
# http://ref.layer8.sh/ja/entry/show/id/2691
if [ "$PS1" ]; then
	#PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
	export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
	export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi



# https://powerline.readthedocs.org/en/latest/overview.html
#. ~/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh

# Colored man pages
# https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
export MANPAGER='less -R'
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# Node.js
export PATH=$PATH:$(npm bin --global 2>/dev/null)
export NODE_PATH=/usr/local/lib/node:~/.npm:$(npm prefix --global 2>/dev/null)/lib/node_modules
#export NODE_PATH=$NODE_PATH:/usr/local/lib/jsctags
# brew install node & npm at /usr/local/homebrew/Cellar/node/0.10.5/
# npm install n at /usr/local/share/npm/lib/node_modules/n/
# versionning node managed by n at /usr/local/n/
# http://nodejs.org/api/modules.html#modules_loading_from_the_global_folders

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh ]]


# Create and attach tmux session
case ${UID} in
0)
    ;;
*)
    # iTerm2
    if [ $ITERM_SESSION_ID ]; then
        ~/bin/tmux_open_windows.sh 2>&1
    fi
esac

# Remove duplicate $PATH entries
# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command 
export PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
export MANPATH=`echo -n $MANPATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
export NODE_PATH=`echo -n $NODE_PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
#typeset -U path		# 配列の各要素値から重複するものを削除

if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
    source $HOME/.zsh/antigen/antigen.zsh

    # Load the oh-my-zsh's library.
    #antigen-lib
    antigen-use oh-my-zsh

    # Bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle brew
    antigen bundle bundler
    #    antigen bundle cpanm
    #    antigen bundle dircycle
    #    antigen bundle encode64
    antigen bundle gem
    #    antigen bundle git
    #    antigen bundle git-flow
    #    antigen bundle github
    antigen bundle heroku
    antigen bundle npm
    antigen bundle osx
    antigen bundle perl
    antigen bundle pip
    antigen bundle python
    antigen bundle rails3
    antigen bundle rbenv
    antigen bundle ruby
    antigen bundle urltools
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-syntax-highlighting
    #    antigen bundle zsh-users/zsh-completions

    # Tell antigen that you're done.
    antigen-apply
fi

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Python
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# http://qiita.com/items/81a9daf716d94b63f94f
alias run-help >/dev/null 2>&1 && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn
