# The following lines were added by compinstall

zstyle ':completion:*' max-errors 2
zstyle ':completion:*' completer _complete _approximate _history _ignored 
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

# Make sure everything uses neovim
EDITOR=nvim

# Begin custom config
# PROMPT="%3c$(git_super_status)$ "
PROMPT='%B%m%~%b$(git_super_status)
|>'
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
alias dps='docker ps --format "{{.ID}}\t{{.Names}}\t{{.Status}}"'
alias dlg='docker logs -f'
alias dtop='docker stats'
alias gst='git status --short'
alias glg='git log --graph --oneline --decorate --all'
alias gb='git branch'
alias gc='git commit -S'
alias scronch='rm -rf'
eval $(thefuck --alias)

alias start_elastic='docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.4.3'

# The golden alias
alias precompile='npm run lint && npm run compile && npm run test'
alias prescronch='sudo chown -R peter . && npm run lint && npm run compile && npm run test'
alias premake='npm run lint && npm run make && npm run test'

# Add nvm utilities
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# use the right version of node
nvm use 10

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
export GPG_TTY=$(tty)
export PATH=~/bin:/home/peter/.cargo/bin:/home/peter/.nvm/versions/node/v10.9.0/bin:/usr/share/Modules/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/home/peter/.local/bin:/home/peter/bin:/home/peter/bin:/usr/local/bin:/home/peter/.cargo/bin

# Add some i3lock stuff
alias lock='i3lock -c000000 -i /home/peter/Pictures/t3_77zygv.png'
alias syssleep='lock && systemctl suspend'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add stuff that should be in the path anyway
PATH=$PATH:/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/peter/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/peter/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/peter/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/peter/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Add installed node modules to the path
PATH=$PATH:~/.nvm/versions/node/v10.15.1/bin/

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Zeit stuff
alias zremote="TERM=screen ssh -t root@167.99.82.200 -L 3000:localhost:3000 -L 8080:localhost:8080 tmux attach"
alias zlog="git log --reverse --format=%B --max-count=20 | sed '/^$/d' | sed 's/^/* /'"

export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
alias prdone='git checkout master && git pull --prune'
