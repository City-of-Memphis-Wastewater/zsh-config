# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set uv to always copy (skips the failed hardlink attempt)
export UV_LINK_MODE=copy

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="robbyrussell"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Faster autosuggestions (debounce to 200ms)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20  # Skip for long pastes

# Ultra-clean prompt: no username, no hostname, just arrow + path + git
PROMPT='%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%{$fg[red]%}%(?.%{$fg[green]%}.%{$fg[red]%}➜)%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Ghost text color — rich purple-magenta that actually shows up
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#d3869b"
# Alternative options if you want to try others:
# Maroon:      fg=#cc241d
# Deep purple: fg=#b16286
# Bright magenta: fg=#d4879c

# some redundancy
alias lab='jupyter lab --ip=127.0.0.1 --port=8080 --no-browser --allow-root --ServerApp.default_url=/lab &'
alias labgo='lab && sleep 2 && termux-open-url http://127.0.0.1:8080/lab'
alias labhere='jupyter lab --ip=127.0.0.1 --port=8080 --no-browser --allow-root --contents-manager.allow-hidden=True --notebook-dir=$(pwd) &'

pretty() {
  local file="$(realpath "$1" 2>/dev/null || echo "$1")"
  [[ -f "$file" ]] || { echo "File not found: $1"; return 1; }
  jq . "$file" > ~/pretty.json 2>/dev/null || { echo "Invalid JSON: $1"; return 1; }
  cd "$(dirname "$file")"
  termux-open-url "http://127.0.0.1:8080/pretty.json"
}

# Full dev IDE
alias labgo='pipx run jupyter lab --ip=127.0.0.1 --port=8080 --no-browser & sleep 2 && termux-open-url http://127.0.0.1:8080/lab'

# Porbably destroy
# Production SCADA dashboard (zero Jupyter visible)
alias eds-dashboard='cd ~/dev/pipeline && \
  pipx run voila Control-Room.ipynb \
    --port=8080 \
    --no-browser \
    --strip_sources=True \
    --theme=dark \
    --template=gridstack & \
  sleep 4 && termux-open-url http://127.0.0.1:8080'

# Kill everything
alias killdash='pkill -f jupyter; pkill -f voila; pkill -f python3'

# Probably destroy
# ONE-LINER PRODUCTION SCADA DASHBOARD (perfect on phone)
alias scada='
  killdash 2>/dev/null || true &&
  jupyter lab \
    --ip=127.0.0.1 \
    --port=8080 \
    --no-browser \
    --ServerApp.default_url=/voila/render/Control-Room.ipynb \
    --VoilaConfiguration.theme=dark \
    --VoilaConfiguration.strip_sources=True \
    & sleep 4 && termux-open-url http://127.0.0.1:8080
'

unsetopt AUTO_CD

alias tg='python -m tg'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
