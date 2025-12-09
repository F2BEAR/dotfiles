export LD_LIBRARY_PATH=/opt/glibc-2.34/lib:$LD_LIBRARY_PATH
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

case "$(hostname)" in
  "faql0") 
    export GIT_ENV="personal"
    export C_USER="facuc"
    ;;
  "TOM-N-008") 
    export GIT_ENV="work"
    export C_USER="facundoc-tkf"
    ;;
  *) export GIT_ENV="default";;
esac

#### history setup ####
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#### starship ####
eval "$(starship init zsh)"

#### Homebrew ####
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#### FZF ####

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Use fd instead of fzf

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

#### fzf theme ####
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

#### Bat ####

export BAT_THEME=tokyonight_night

#### Eza (better ls) ####

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

#### thefuck ####
eval $(thefuck --alias)
eval $(thefuck --alias fk)

#### Zoxide ####
eval "$(zoxide init zsh)"

alias cd="z"

#### zsh-autosuggestions ####
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#### zsh-syntax-highlighting ####
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#### Curlier Config ####
export CURLIER_REQUESTS_DIR="$HOME/dev/curlier_requests"

#### NVM ####
export NVM_DIR="$HOME/.nvm"
export NVM_SYMLINK_CURRENT=true
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

#### ZSH Vi Mode ####
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

#### pnpm ####
export PNPM_HOME="/home/faq/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#### Bitwarden CLI ####
# Unlock Bitwarden vault and export session token
bw-unlock() {
  export BW_SESSION=$(bw unlock --raw)
  if [ $? -eq 0 ]; then
    echo "✅ Bitwarden vault unlocked"
  else
    echo "❌ Failed to unlock Bitwarden vault"
  fi
}

# Lock Bitwarden vault
bw-lock() {
  bw lock
  unset BW_SESSION
  echo "🔒 Bitwarden vault locked"
}

# Get password from Bitwarden
bw-get() {
  if [ -z "$BW_SESSION" ]; then
    echo "⚠️  Bitwarden vault is locked. Run 'bw-unlock' first."
    return 1
  fi
  
  if [ -z "$1" ]; then
    echo "Usage: bw-get <search-term>"
    return 1
  fi
  
  bw get notes "$1" --session $BW_SESSION
}

# Search items in Bitwarden
bw-search() {
  if [ -z "$BW_SESSION" ]; then
    echo "⚠️  Bitwarden vault is locked. Run 'bw-unlock' first."
    return 1
  fi
  
  if [ -z "$1" ]; then
    echo "Usage: bw-search <search-term>"
    return 1
  fi
  
  bw list items --search "$1" --session $BW_SESSION | jq -r '.[] | "\(.name) - \(.login.username)"'
}

#### Aliases ####

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias edit-wezterm="nvim /mnt/c/Users/facundoc-tkf/.wezterm.lua"
alias edit-nvim="cd ~/dotfiles/nvim/.config/nvim/ && nvim"
alias curlier="~/scripts/curlier/curlier.sh"
alias bwem='source ~/scripts/secretManager/bw-env.sh'
alias syncwez="~/dotfiles/wezterm/sync_wezterm.sh"
alias syncwsl="~/dotfiles/wsl/sync_wsl.sh"
alias mdfzf="~/scripts/mdfzf/mdfzf.sh"
alias gdiff="git diff --ours --theirs"
alias gconflict='files=$(git diff --name-only --diff-filter=U) && [ -n "$files" ] && nvim $files || echo "No merge conflicts found."'
alias bwu="bw-unlock"
alias bwl="bw-lock"
alias bwg="bw-get"
alias bws="bw-search"

. "/home/faq/.deno/env"

# Forzar inicio en home si estamos en Windows paths
if [[ "$PWD" == /mnt/c/* ]]; then
    cd ~
fi

export PATH="/usr/local/bin:$PATH"

if [[ $- == *i* ]]; then
  fastfetch
fi
