#!/usr/bin/env zsh

# Parse getopt-style help texts for options and generate zsh(1) completion functions
# http://github.com/RobSis/zsh-completion-generator

# Fetch $0 according to plugin standard
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
ZSH_COMPLETION_GENERATOR_SRCDIR=${0:A:h}

# Set completion directory
if [ -z "$GENCOMPL_FPATH" ]; then
    ZSH_COMPLETION_GENERATOR_DIR="$ZSH_COMPLETION_GENERATOR_SRCDIR/completions"
else
    ZSH_COMPLETION_GENERATOR_DIR="$GENCOMPL_FPATH"
fi

# Add to fpath if not already present
[[ -z "${fpath[(r)$ZSH_COMPLETION_GENERATOR_DIR]}" ]] && fpath=($fpath $ZSH_COMPLETION_GENERATOR_DIR)

# Set Python interpreter
python=${GENCOMPL_PY:-python3}

# Create completion directory if it doesn't exist
[[ ! -d $ZSH_COMPLETION_GENERATOR_DIR ]] && command mkdir -p $ZSH_COMPLETION_GENERATOR_DIR

# Define default programs
local -a programs
zstyle -a :plugin:zsh-completion-generator programs programs
(( ${#programs} )) || programs=( "ggrep" "groff -h" "nl" )

# Generate completions for default programs
() {
    local prg name help code
    local -a i
    for prg in "${programs[@]}"; do
        name=$prg
        help=--help
        if [[ ${prg% *} != $prg ]]; then
            i=( "${(@s/ /)prg}" )
            name=$i[1]
            [[ -n "$i[2]" ]] && help="$i[2]"
        fi

        if [[ ! -f $ZSH_COMPLETION_GENERATOR_DIR/_$name ]]; then
            $name $help 2>&1 | $python $ZSH_COMPLETION_GENERATOR_SRCDIR/help2comp.py $name >! $ZSH_COMPLETION_GENERATOR_DIR/_$name || {
                code="${pipestatus[1]}"
                command rm -f $ZSH_COMPLETION_GENERATOR_DIR/_$name
                [[ ! -f $ZSH_COMPLETION_GENERATOR_DIR/err_$name ]] && \
                    echo "No options found for $name. Was fetching from following invocation: \`$name $help'.\nProgram reacted with exit code: $code." >! $ZSH_COMPLETION_GENERATOR_DIR/err_$name
            }
        fi
    done
}

# Completion generator function
gencomp() {
    if [[ -z "$1" || "$1" = "-h" || "$1" = "--help" ]]; then
        echo "Usage: gencomp program [--argument-for-help-text]"
        echo
        return 1
    fi

    local help=${2:---help}

    "$1" $help 2>&1 | $python $ZSH_COMPLETION_GENERATOR_SRCDIR/help2comp.py $1 >! $ZSH_COMPLETION_GENERATOR_DIR/_$1 || {
        local code="${pipestatus[1]}"
        command rm -f $ZSH_COMPLETION_GENERATOR_DIR/_$1
        echo "No options found for '$1'. Was fetching from following invocation: \`$1 $help'.\nThe program reacted with exit code: $code."
        return $code
    }
}