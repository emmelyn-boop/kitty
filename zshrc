
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# ZSH_THEME_R

# Uncomment the following line to change how often to auto-update (in days).
export update_zsh_days=1

# Zsh autosuggestion and syntax highlighting
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

source $ZSH/oh-my-zsh.sh



alias tn="time nvim"
# Custom Aliases
alias gb="gradle build"
alias gr="gradle run"
alias cloned="git clone"
alias update="sudo pacman -Syy"
alias upgrade="sudo pacman -Syyuu"
alias blackarch="sudo pacman -Syyuu --needed --overwrite '*' blackarch"
alias c="clear"
alias q="exit"
alias hd="hexdump -C"
alias msf="systemctl start postgresql && msfconsole"
alias pingoogle="ping 8.8.8.8"
alias httpd-start="sudo mkdir /var/log/httpd ; systemctl restart httpd mariadb"
alias httpd-stop="systemctl stop httpd mariadb"
alias httpd-status="systemctl status httpd mariadb"
alias trimall="sudo fstrim -va"
alias reflesh="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist"
alias nanosu="sudo nano"
alias vimsu="sudo vim"
alias cat="bat --theme=base16"
alias ls="exa --icons"
alias update="paru -Syu --nocombinedupgrade"
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias music="ncmpcpp"
alias ll='eza --icons=always --color=always -la'

# Update Python Path
export PATH="$HOME/bin:$PATH"
export PYTHONPATH="/usr/bin/python:$PWD"

# Visual and editor setup
export VISUAL="${EDITOR}"
export EDITOR='geany'
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Deploying root access for %u. Password pls: "
export BAT_THEME="base16"

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Zsh completions
autoload -Uz compinit
for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done
compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }

# Completion and prompt styles
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# Command completion expansion
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# History setup
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Auto directory change
setopt AUTOCD
setopt PROMPT_SUBST
setopt MENU_COMPLETE
setopt LIST_PACKED
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# Command not found handler
command_not_found_handler() {
	printf "%s%s? I don't know what is it\n" "$acc" "$0" >&2
    return 127
}

# Zsh plugins sources
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Keybindings for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char

# Terminal title updates
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# System management aliases
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias update="paru -Syu --nocombinedupgrade"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias music="ncmpcpp"
alias cat="bat --theme=base16"
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'

# CUDA and cuDNN paths
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH
export CUDNN_INCLUDE_DIR=/usr/local/cuda/include
export CUDNN_LIB_DIR=/usr/local/cuda/lib64

# Initializing Atuin
eval "$(atuin init zsh)"

# Autojump (Navigation Tool)
source /usr/share/autojump/autojump.zsh

# fzf (Fuzzy Finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Direnv (Environment Management)
eval "$(direnv hook zsh)"

# Powerlevel10k (Prompt Enhancement)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable zsh-z plugin for faster directory navigation
source $ZSH_CUSTOM/plugins/zsh-z/zsh-z.plugin.zsh

# Weather command (wttr)
alias weather="wttr"

# Ripgrep for fast searching
alias rg="ripgrep"

# tmux (Terminal Multiplexer)
alias tmux="tmux new-session -A -s main"


# starship
eval "$(starship init zsh)"
autoload -U compinit && compinit

compinit


