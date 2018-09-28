# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/Users/petereast/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# Show git current branch
source ~/clones/zsh-git-prompt/zshrc.sh

# Begin custom config
# PROMPT="%3c$(git_super_status)$ "
PROMPT='%B%m%~%b$(git_super_status) %# '
RPS1="%_ :%?"

# Add brew-installed programs to PATH
PATH=$PATH:/usr/local/bin

# Stuff for vim bindings
export KEYTIMEOUT=0
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/[vi]}/(main|viins)/}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Add drun
alias drun='docker run -it --rm --network=host -v $(pwd):/opt/work --workdir=/opt/work'

# Add swagger
alias swg='docker run -it -p 1236:8080 -e SWAGGER_JSON=/swaggerd/api.yaml -v $PWD:/swaggerd -d swaggerapi/swagger-ui'

# Add Rust utilities to PATH
PATH=$PATH:~/.cargo/bin

# Add a few custom aliases

alias :q='exit'
alias ll='ls -l'
alias la='ls -a'
alias dps='docker ps'
alias gst='git status'
alias glg='git log'
alias gb='git branch'
alias scronch='rm -rf'
eval $(thefuck --alias)

# The golden alias
alias precompile='npm run lint && npm run compile && npm run test'
alias premake='npm run lint && npm run compile && npm run test'

# Add nvm utilities
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
export GPG_TTY=$(tty)
export PATH=~/bin:/home/peter/.cargo/bin:/home/peter/.nvm/versions/node/v10.9.0/bin:/usr/share/Modules/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/home/peter/.local/bin:/home/peter/bin:/home/peter/bin:/usr/local/bin:/home/peter/.cargo/bin
