# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
alias python=python3

# Show git current branch
source ~/clones/zsh-git-prompt/zshrc.sh

typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='20'
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

alias aw='aws --endpoint-url http://localhost:4566 --region us-east-1'
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
alias b='git checkout -b'
alias scronch='rm -rf'
eval $(thefuck --alias)

alias start_elastic='docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.4.3'

# The golden alias
alias precompile='npm run lint && npm run compile && npm run test'
alias prescronch='sudo chown -R peter . && npm run lint && npm run compile && npm run test'
alias premake='npm run lint && npm run make && npm run test'

echo '[debug] alisaes done'

# Run this asynchronously because it takes forever for some reason
source ~/.zsh-nvm/zsh-nvm.plugin.zsh &
echo '[debug] nvm done'

autoload -U +X compinit && compinit
echo '[debug] autocomplete 1/2'
autoload -U +X bashcompinit && bashcompinit
echo '[debug] autocomplete 2/2'
export GPG_TTY=$(tty)
export PATH=~/bin:~/.cargo/bin:/home/peter/.nvm/versions/node/v10.9.0/bin:/usr/share/Modules/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/home/peter/.local/bin:/home/peter/bin:/home/peter/bin:/usr/local/bin:/Users/petereast/.cargo/bin

# Add some i3lock stuff
alias lock='i3lock -c000000 -i /home/peter/Pictures/t3_77zygv.png'
alias syssleep='lock && systemctl suspend'

echo '[debug] autocomplete done'

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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/Users/petereast/Library/Python/3.7/bin:/usr/local/go/bin:$PATH"

alias prdone='git checkout master && git pull --prune'
alias prdev='git checkout dev && git pull --prune'
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/petereast/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export JAVA_HOME=$(/usr/libexec/java_home)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/petereast/.sdkman"
[[ -s "/Users/petereast/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/petereast/.sdkman/bin/sdkman-init.sh"
export PATH="$PATH:/Users/petereast/Library/Application Support/Coursier/bin"

# Github CLI - make draft PRs
alias pr='gh pr create --draft'
