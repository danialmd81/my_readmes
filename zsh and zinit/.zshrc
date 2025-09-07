# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

######################################################################################
## History settings
######################################################################################

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

######################################################################################
## ZSH Basic Options
######################################################################################

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

######################################################################################
## Load a few important annexes, without Turbo
######################################################################################
zinit light-mode for \
	zdharma-continuum/zinit-annex-as-monitor \
	zdharma-continuum/zinit-annex-bin-gem-node \
	zdharma-continuum/zinit-annex-patch-dl \
	zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

######################################################################################
#### READ ME
######################################################################################
## for updating plugins
# zinit update --parallel 40
## for updating zinit itself
# zinit self-update
######################################################################################
## Theme
######################################################################################

#### Load Powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k
#### Load powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# #### Load pure theme
# zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
# zinit light sindresorhus/pure

# #### Load starship theme
# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

######################################################################################
## Load plugins and fzf completions
######################################################################################

# Oh-My-Zsh libraries
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh

# Oh-My-Zsh plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages

# Other plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-autosuggestions

# LS_COLORS plugin
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
	atpull'%atclone' pick"clrs.zsh" nocompile'!' \
	atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# FZF and related plugins
zinit light Aloxaf/fzf-tab
zinit ice as"program" from"gh-r"
zinit ice has"fzf" id-as"junegunn/fzf_completions" pick"/dev/null" multisrc"shell/completion.zsh shell/key-bindings.zsh"
zinit light junegunn/fzf

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
	zsh-users/zsh-completions

## FZF configuration
if [[ -x "$(command -v fzf)" ]]; then
	export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
	  --info=inline-right \
	  --ansi \
	  --layout=reverse \
	  --border=rounded \
	  --color=border:#27a1b9 \
	  --color=fg:#c0caf5 \
	  --color=gutter:#16161e \
	  --color=header:#ff9e64 \
	  --color=hl+:#2ac3de \
	  --color=hl:#2ac3de \
	  --color=info:#545c7e \
	  --color=marker:#ff007c \
	  --color=pointer:#ff007c \
	  --color=prompt:#2ac3de \
	  --color=query:#c0caf5:regular \
	  --color=scrollbar:#27a1b9 \
	  --color=separator:#ff9e64 \
	  --color=spinner:#ff007c \
	"
fi

#### fzf Key bindings:
#### - Ctrl+T to paste selected files/directories onto the command line
#### - Ctrl+R for interactive history search
#### - Alt+C to cd into selected directory

## Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${LS_COLORS:-}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

######################################################################################
## Key bindings
######################################################################################

## Up/Down arrow keys to search history based on current input
bindkey "^[[A" history-beginning-search-backward # search history with up key
bindkey "^[[B" history-beginning-search-forward  # search history with down key

## Ctrl + Arrow keys for moving the cursor by words
bindkey '\e[1;5C' forward-word  # Ctrl+Right
bindkey '\e[1;5D' backward-word # Ctrl+Left

######################################################################################
## User configuration
######################################################################################
# Add directories to the end of the path if they exist and are not already in the path
# Link: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function pathappend() {
	for ARG in "$@"; do
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="${PATH:+"$PATH:"}$ARG"
		fi
	done
}

# Add directories to the beginning of the path if they exist and are not already in the path
function pathprepend() {
	for ARG in "$@"; do
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="$ARG${PATH:+":$PATH"}"
		fi
	done
}

# Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin" "$HOME/bin/nekoray"

## append other paths
pathappend "$HOME/.cargo/bin" "$HOME/go/bin" "$HOME/.rbenv/bin"

## Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

#### Uncomment the following lines to enable Wayland support
export QT_QPA_PLATFORM=wayland

#### Uncomment the following lines to enable ZYpp package manager support
# export ZYPP_PCK_PRELOAD=1
# export ZYPP_CURL2=1 # default is curl2

## Auth tokens and environment variables
export LOCALSTACK_AUTH_TOKEN="ls-coRowIlu-GIFi-1843-VArA-DESOYoToc20b"

## XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

######################################################################################
## Aliases
######################################################################################
#### General
alias _='sudo '
alias g=git
alias l='ls -lah'
alias ls='ls --color=tty'
alias la='ls -lAh'
alias ll='ls -lh'
alias md='mkdir -p'
alias rd=rmdir
alias which-command=whence
alias cls="clear"

#### ZSH
alias zshconfig="code ~/.zshrc"

#### Misc

#### Pop-Os system76-power
alias gpu="system76-power graphics"
alias gpu-integrated="sudo system76-power graphics integrated"
alias gpu-hybrid="sudo system76-power graphics hybrid"
alias gpu-nvidia="sudo system76-power graphics nvidia"
alias gpu-compute="sudo system76-power graphics compute"
alias cpu="system76-power profile"
alias cpu-silent="system76-power profile battery"
alias cpu-normal="system76-power profile balanced"
alias cpu-overboost="system76-power profile performance"

#### R
alias r="radian"

#### Qt
alias qt-cmake="/home/danial/Qt/Tools/CMake/bin/cmake"
alias qt-cmake-gui="/home/danial/Qt/Tools/CMake/bin/cmake-gui"
alias qt6-qmake="/home/danial/Qt/6.9.0/gcc_64/bin/qmake"
alias qt5-qmake="/home/danial/Qt/5.15.2/gcc_64/bin/qmake"
alias find-cmake="find . -name 'CMakeLists.txt' -exec dirname {} \; | xargs -I{} readlink -f {} | jq -R . | jq -s '{ \"cmake.sourceDirectory\": . }'"
