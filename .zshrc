# setup antigen
DOTFILES_PATH=${HOME}/.dotfiles
source ${DOTFILES_PATH}/antigen/antigen.zsh
antigen init ${HOME}/.antigenrc

# history
export HISTFILE="${ZDOTDIR:-${HOME}}/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=2000
export HISTORY_IGNORE="(ls|la|ll|cd|cd -|pwd|exit|date|* --help)"

# options
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history
setopt pushd_ignore_dups

# styles
export LSCOLORS="exfxbxdxcxegedabagacad"
export LS_COLORS="di=34:ln=35:so=31:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
zstyle ':completion:*:default' list-colors 'di=34:ln=35:so=31:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'

# customs
if [[ -e "${HOME}/.bin" ]]; then
    export PATH="${HOME}/.bin:${PATH}"
fi
if [[ -e "${HOME}/.pyenv" ]]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
if [[ -e "${HOME}/.profile" ]]; then
    source ${HOME}/.profile
fi

# aliases
alias la='ls -A'
alias ll='ls -lAh'
alias cp='cp -a'
alias rm='rm -ir'
alias grep='grep -nI --color=auto'
alias diff='diff -uNr --color=auto'
alias du='du -h'
alias df='df -h'
alias sudo='sudo '

alias vi='vim'

alias pip='pip --no-cache-dir'
alias pip2='pip2 --no-cache-dir'
alias pip3='pip3 --no-cache-dir'

if [[ -e "${HOME}/.aliases" ]]; then
    source ${HOME}/.aliases
fi
