# # Enable Powerlevel10k instant prompt (keep this at the top)
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
HIST_STAMPS="dd/mm/yyyy"

# # Load powerlevel10k config
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source the script before compinit to ensure completion works correctly
source $HOME/.zsh/custom/zsh-completion-generator/zsh-completion-generator.plugin.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# # Load Powerlevel10k theme
# zinit ice depth=1
# zinit light romkatv/powerlevel10k

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# # Load starship theme
# # line 1: `starship` binary as command, from github release
# # line 2: starship setup at clone(create init.zsh, completion)
# # line 3: pull behavior same as clone, source init.zsh
# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

# Oh My Zsh compatibility - load useful libraries
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh
# zinit snippet OMZL::theme-and-appearance.zsh

# Load plugins (replaces plugins in Oh My Zsh)
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::ssh

# fzf shell integration
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# Load fzf shell integration scripts
# Key bindings:
# - Ctrl+T to paste selected files/directories onto the command line
# - Ctrl+R for interactive history search
# - Alt+C to cd into selected directory
zinit ice has"fzf" id-as"junegunn/fzf_completions" pick"/dev/null" multisrc"shell/completion.zsh shell/key-bindings.zsh"
zinit light junegunn/fzf

# Ctrl + Arrow keys for moving the cursor by words
bindkey '\e[1;5C' forward-word      # Ctrl+Right
bindkey '\e[1;5D' backward-word     # Ctrl+Left

# Load your custom plugins
source $HOME/.zsh/custom/update-man-completion.zsh
source $HOME/.zsh/custom/zsh-shift-select.zsh
# source $HOME/.zsh/custom/zsh-shift-select/zsh-shift-select.plugin.zsh

# User configuration - PATH settings
PATH="$PATH:$HOME/go/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/zig"
PATH="$PATH:$HOME/.rbenv/bin"
PATH="$PATH:/opt/mssql-tools/bin"
PATH="$PATH:$HOME/android/android_sdk/cmdline-tools/latest/bin/"
PATH="$PATH:$HOME/android/android_sdk/platforms/"
PATH="$PATH:$HOME/android/android_sdk/platforms-tools/"
PATH="$PATH:$HOME/android/android_sdk/build-tools/"

# Editor configuration
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='code'
fi

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# Initialize rbenv
eval "$(rbenv init -)"

# Auth tokens and environment variables
export LOCALSTACK_AUTH_TOKEN="ls-coRowIlu-GIFi-1843-VArA-DESOYoToc20b"

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

#
export ANDROIDSDK="$HOME/android/android_sdk/"
export ANDROIDNDK="$HOME/android/android-ndk-r25b"
export ANDROIDAPI="31"  # Target API version of your application
export NDKAPI="21"  # Minimum supported API version of your application
export ANDROIDNDKVER="25b"  # Version of the NDK you installed

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
 

# Aliases
alias _='sudo '
alias g=git
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'
alias md='mkdir -p'
alias rd=rmdir
alias which-command=whence

alias zshconfig="code ~/.zshrc"

alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias upgrade-list="apt list --upgradable"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias reinstall="sudo apt reinstall"
alias autoremove="sudo apt autoremove"
alias autoclean="sudo apt autoclean"
alias autopurge="sudo apt autopurge"
alias search="apt search"

alias cls="clear"
alias r="radian"

alias qt-cmake="/home/danial/Qt/Tools/CMake/bin/cmake"
alias qt-cmake-gui="/home/danial/Qt/Tools/CMake/bin/cmake-gui"
alias qt6-qmake="/home/danial/Qt/6.9.0/gcc_64/bin/qmake"
alias qt5-qmake="/home/danial/Qt/5.15.2/gcc_64/bin/qmake"


alias graphics="system76-power graphics"
alias graphics-hybrid="sudo system76-power graphics hybrid"
alias graphics-nvidia="sudo system76-power graphics nvidia"
alias graphics-integrated="sudo system76-power graphics integrated"
alias graphics-compute="sudo system76-power graphics compute"
alias profile="system76-power profile"
alias profile-battery="system76-power profile battery"
alias profile-balanced="system76-power profile balanced"
alias profile-performance="system76-power profile performance"

alias find-cmake="find . -name 'CMakeLists.txt' -exec dirname {} \; | xargs -I{} readlink -f {} | jq -R . | jq -s '{ \"cmake.sourceDirectory\": . }'"
