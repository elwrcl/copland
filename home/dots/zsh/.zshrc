# elarsın muhtesem configi
eval "$(starship init zsh)"

# deps
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF
#source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# eza alias
alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'

# allias extra
alias cat='bat'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

alias nano='micro'
alias edit='micro'
export EDITOR=micro
export VISUAL=micro
export SUDO_EDITOR=micro

# arch shit
#alias update='sudo pacman -Syu'
#alias install='sudo pacman -S'
#alias remove='sudo pacman -Rns'
#alias search='pacman -Ss'
#alias orphans='sudo pacman -Rns $(pacman -Qtdq)'
#alias mirrors='sudo reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'

# system
alias sysinfo='fastfetch'
alias monitor='btop'
alias ports='sudo netstat -tulpn'
alias myip='curl ifconfig.me'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# confs
alias zshrc='micro ~/.zshrc'
alias reload='source ~/.zshrc'

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
setopt AUTO_CD

# intro
if [[ -o interactive ]]; then
    ~/.config/fastfetch/fastfetch_kayan.sh
fi

# colors
export CLICOLOR=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#mesa
export MESA_SHADER_CACHE_MAX_SIZE=2G
export MESA_SHADER_CACHE_DIR=/tmp/mesa_shader_cache
export PATH="$HOME/.local/bin:$PATH"
