typeset -U path
path=(~/.zshbin "${path[@]}")
typeset -U fpath
fpath=(~/.zshfunc "${fpath[@]}")

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000
ttyctl -f
bindkey -e
setopt autocd beep completealiases extendedglob nomatch notify
setopt sharehistory extendedhistory histignorealldups histreduceblanks
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
source ~/.zshui

alias ls='ls -Fh --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias vim='nvim'

if [[ $- =~ i ]] && [[ -z $TMUX ]]; then exec tmux new -As0; fi
