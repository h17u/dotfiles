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

export BROWSER=w3m
export EDITOR=vim
set meta-flag on set input-meta on set output-meta on set convert-meta off # for japanese
export TERM=xterm-256color
export PAGER=less
export MANPAGER='less -R'
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
setopt share_history inc_append_history hist_no_store hist_verify hist_reduce_blanks
setopt prompt_subst correct list_packed nolistbeep
setopt list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt complete_aliases
setopt multibyte print_eight_bit
setopt auto_menu
setopt auto_param_slash auto_remove_slash
setopt magic_equal_subst multios brace_ccl interactive_comments
# setopt extended_glob
#setopt globdots
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
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --RAW-CONTROL-CHARS'
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
alias ls='gls --color=auto'
alias ll='ls -l' la='ls -al'
alias diff=$(brew --prefix colordiff)/bin/colordiff
alias git=hub

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


# Completion
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
source /usr/local/etc/bash_completion.d/tig-completion.bash
#autoload -Uz vcs_info
#autoload -Uz promptinit && promptinit
#autoload -Uz predict-on && predict-on

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


# bind UP and DOWN arrow keys
for keycode in '[' 'O'; do
  bindkey "^[${keycode}A" history-substring-search-up
  bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


# http://memo.officebrook.net/20090205.html
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

# C-x, C-pでコマンドをクリップボードにコピーする
# http://d.hatena.ne.jp/hiboma/20120315/1331821642
function pbcopy-buffer() { #{{{
  print -rn $BUFFER | pbcopy
  zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer
#}}}


# 20111202
# Setup Amazon EC2 Command-Line Tools
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

### Added by the Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

#20130306
### Added for rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"


# added for my local bin directory
#export PATH=$PATH:$EC2_HOME/bin
export PATH=$PATH:~/bin




# for gnu coreutils alias
if [ "$PS1" ]; then
        export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
        export PATH=$(brew --prefix gnu-sed)/libexec/gnubin:$PATH
        export MANPATH=$(brew --prefix coreutils)/libexec/gnuman:$MANPATH
        export MANPATH=$(brew --prefix gnu-sed)/libexec/gnuman:$MANPATH
fi


# Node.js
export PATH=$PATH:$(npm bin --global 2>/dev/null)
export NODE_PATH=$NODE_PATH:$(brew --prefix)/lib/node
export NODE_PATH=$NODE_PATH:~/.npm
export NODE_PATH=$NODE_PATH:$(npm prefix --global)/lib/node_modules
export NODE_PATH=$NODE_PATH:$(brew --prefix)/lib/jsctags
eval "$(npm completion 2>/dev/null)"
# eval "$(bower completion 2>/dev/null)"
# brew install node & npm at /usr/local/homebrew/Cellar/node/0.10.5/
# npm install n at /usr/local/share/npm/lib/node_modules/n/
# versionning node managed by n at /usr/local/n/
# http://nodejs.org/api/modules.html#modules_loading_from_the_global_folders


# Python
export PATH=$(brew --prefix)/share/python:$PATH
export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH

# go
export GOROOT=$(brew --prefix go)
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin


# Create and attach tmux session #{{{
case ${UID} in
0)
    ;;
*)
    # iTerm2
    if [ $ITERM_SESSION_ID ]; then
        ~/bin/tmux_open_windows.sh 2>&1
    fi
esac #}}}

# Remove duplicate $PATH entries
# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command 
export PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
export MANPATH=`echo -n $MANPATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
export NODE_PATH=`echo -n $NODE_PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`
#typeset -U path cdpath fpath manpath

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
    #}}}

    # Bundles othoer repo
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle zsh-users/zsh-completions src

    # Tell antigen that you're done.
    antigen apply
fi
#}}}

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# http://qiita.com/items/81a9daf716d94b63f94f
alias run-help >/dev/null 2>&1 && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn



# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim:set et ts=4 sts=2 sw=2 tw=0 fdm=marker:
