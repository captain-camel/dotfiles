PROMPT='%~ %# '

bindkey -v
bindkey -v '^?' backward-delete-char

setopt APPEND_HISTORY

export CLICOLOR=1

eval "$(mise activate zsh)"
