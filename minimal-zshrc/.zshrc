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

# Source the script before compinit to ensure completion works correctly(here)


# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

# compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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
zinit snippet OMZL::clipboard.zshw
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

# Key bindings:
# - Ctrl+T to paste selected files/directories onto the command line
# - Ctrl+R for interactive history search
# - Alt+C to cd into selected directory

# Load fzf shell integration scripts
zinit ice has"fzf" id-as"junegunn/fzf_completions" pick"/dev/null" multisrc"shell/completion.zsh shell/key-bindings.zsh"
zinit light junegunn/fzf

# Ctrl + Arrow keys for moving the cursor by words
bindkey '\e[1;5C' forward-word      # Ctrl+Right
bindkey '\e[1;5D' backward-word     # Ctrl+Left

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

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

alias cls="clear"
alias r="radian"

alias find-cmake="find . -name 'CMakeLists.txt' -exec dirname {} \; | xargs -I{} readlink -f {} | jq -R . | jq -s '{ \"cmake.sourceDirectory\": . }'"