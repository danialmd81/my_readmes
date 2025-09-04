# zsh-shift-select: Enhanced text selection and clipboard management for zsh
# Based on https://stackoverflow.com/a/30899296

# Clipboard helpers
function _zsh_clipboard_copy() {
    if command -v xclip >/dev/null 2>&1; then
        xclip -in -selection clipboard
    elif command -v xsel >/dev/null 2>&1; then
        xsel --input --clipboard
    else
        print "Error: Neither xclip nor xsel found. Please install one of them." >&2
        return 1
    fi
}

function _zsh_clipboard_paste() {
    if command -v xclip >/dev/null 2>&1; then
        xclip -out -selection clipboard
    elif command -v xsel >/dev/null 2>&1; then
        xsel --output --clipboard
    else
        print "Error: Neither xclip nor xsel found. Please install one of them." >&2
        return 1
    fi
}

# Region manipulation functions
r-delregion() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}
r-deselect() {
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}
r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

# Key bindings for selection
for key     kcap   seq        mode   widget (
    sleft   kLFT   $'\e[1;2D' select   backward-char
    sright  kRIT   $'\e[1;2C' select   forward-char
    sup     kri    $'\e[1;2A' select   up-line-or-history
    sdown   kind   $'\e[1;2B' select   down-line-or-history
    send    kEND   $'\e[1;2F' select   end-of-line
    send2   x      $'\e[4;2~' select   end-of-line
    shome   kHOM   $'\e[1;2H' select   beginning-of-line
    shome2  x      $'\e[1;2~' select   beginning-of-line
    left    kcub1  $'\eOD'    deselect backward-char
    right   kcuf1  $'\eOC'    deselect forward-char
    end     kend   $'\eOF'    deselect end-of-line
    end2    x      $'\e4~'    deselect end-of-line
    home    khome  $'\eOH'    deselect beginning-of-line
    home2   x      $'\e1~'    deselect beginning-of-line
    csleft  x      $'\e[1;6D' select   backward-word
    csright x      $'\e[1;6C' select   forward-word
    csend   x      $'\e[1;6F' select   end-of-line
    cshome  x      $'\e[1;6H' select   beginning-of-line
    del     kdch1   $'\e[3~'  delregion delete-char
    bs      x       $'^?'     delregion backward-delete-char
    cdel    x       $'\e[3;5~' delregion delete-word
    cbs     x       $'^H' delregion backward-kill-word
  ) {
  eval "key-$key() {
    r-$mode $widget \$@
  }"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}

# Fix zsh-autosuggestions
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
  key-right
)

# Enhanced clipboard functions
function zle-clipboard-cut {
  if ((REGION_ACTIVE)); then
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | _zsh_clipboard_copy
    zle kill-region
  fi
}
zle -N zle-clipboard-cut

function zle-clipboard-copy {
  if ((REGION_ACTIVE)); then
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | _zsh_clipboard_copy
  else
    zle send-break
  fi
}
zle -N zle-clipboard-copy

function zle-clipboard-paste {
  if ((REGION_ACTIVE)); then
    zle kill-region
  fi
  LBUFFER+="$(clippaste)"
}
zle -N zle-clipboard-paste

# Terminal interrupt handling
function zle-pre-cmd {
  [[ -t 0 ]] && stty intr "^@"
}
precmd_functions=("zle-pre-cmd" ${precmd_functions[@]})

function zle-pre-exec {
  [[ -t 0 ]] && stty intr "^C"
}
preexec_functions=("zle-pre-exec" ${preexec_functions[@]})

# Key bindings for clipboard operations
for key     kcap    seq           widget              arg (
    cx      _       $'^X'         zle-clipboard-cut   _
    cc      _       $'^C'         zle-clipboard-copy  _
    cv      _       $'^V'         zle-clipboard-paste _
    csc     _       $'\e[1;6C'    zle-clipboard-copy  _
) {
  if [ "${arg}" = "_" ]; then
    eval "key-$key() {
      zle $widget
    }"
  else
    eval "key-$key() {
      zle-$widget $arg \$@
    }"
  fi
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}

# Select all functionality
function widget::select-all() {
  local buflen=$(echo -n "$BUFFER" | wc -m | bc)
  CURSOR=$buflen  
  zle set-mark-command
  while [[ $CURSOR > 0 ]]; do
    zle beginning-of-line
  done
}
zle -N widget::select-all
bindkey '^a' widget::select-all

# Undo functionality
bindkey "^Z" undo
