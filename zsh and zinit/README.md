**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Zinit Wiki](#zinit-wiki)
- [Quick Start](#quick-start)
  - [Install](#install)
    - [Automatic Installation (Recommended)](#automatic-installation-recommended)
    - [Manual Installation](#manual-installation)
  - [Usage](#usage)
    - [Introduction](#introduction)
    - [Plugins and snippets](#plugins-and-snippets)
    - [Upgrade Zinit and plugins](#upgrade-zinit-and-plugins)
    - [Turbo and lucid](#turbo-and-lucid)
    - [Migration](#migration)
    - [More Examples](#more-examples)
- [Completions](#completions-2)
  - [Calling `compinit` Without Turbo Mode](#calling-compinit-without-turbo-mode)
  - [Calling `compinit` With Turbo Mode](#calling-compinit-with-turbo-mode)
  - [Ignoring Compdefs](#ignoring-compdefs)
  - [Disabling System-Wide `compinit` Call (Ubuntu)](#disabling-system-wide-compinit-call-ubuntu)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Zinit Wiki

The information in this README is complemented by the [Zinit
Wiki](https://zdharma.github.io/zinit/wiki/). The README is an introductory overview of
Zinit while the Wiki gives a complete information with examples. Make sure to
read it to get the most out of Zinit.

# Quick Start

## Install

### Automatic Installation (Recommended)

The easiest way to install Zinit is to execute:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```

This will install Zinit in `~/.zinit/bin`.
`.zshrc` will be updated with three lines of code that will be added to the bottom.
The lines will be sourcing `zinit.zsh` and setting up completion for command `zinit`.

After installing and reloading the shell compile Zinit with `zinit self-update`.

## Usage

### Introduction

### Plugins and snippets

Plugins can be loaded using `load` or  `light`.

```zsh
zinit load  <repo/plugin> # Load with reporting/investigating.
zinit light <repo/plugin> # Load without reporting/investigating.
```

If you want to source local or remote files (using direct URL), you can do so with `snippet`.

```zsh
zinit snippet <URL>
```

Such lines should be added to `.zshrc`. Snippets are cached locally, use `-f` option to download
a fresh version of a snippet, or `zinit update {URL}`. Can also use `zinit update --all` to
update all snippets (and plugins).

**Example**

```zsh
# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

# Snippet
zinit snippet https://gist.githubusercontent.com/hightemp/5071909/raw/
```

**Prompt(Theme) Example**

This is [powerlevel10k](https://github.com/romkatv/powerlevel10k), [pure](https://github.com/sindresorhus/pure), [starship](https://github.com/starship/starship) sample:

```zsh
# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

# Load starship theme
zinit ice as"command" from"gh-r" \ # `starship` binary as command, from github release
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \ # starship setup at clone(create init.zsh, completion)
          atpull"%atclone" src"init.zsh" # pull behavior same as clone, source init.zsh
zinit light starship/starship
```

### Upgrade Zinit and plugins

Zinit can be updated to `self-update` and plugins to `update`.

```zsh
# Self update
zinit self-update

# Plugin update
zinit update

# Plugin parallel update
zinit update --parallel

# Increase the number of jobs in a concurrent-set to 40
zinit update --parallel 40
```

### Turbo and lucid

Turbo and lucid are the most used options.

#### Turbo Mode

Turbo mode is the key to performance. It can be loaded asynchronously, which makes a huge difference when the amount of plugins increases.

Usually used as `zinit ice wait"<SECONDS>"`, let's use the previous example:

```zsh
zinit ice wait    # wait is same wait"0"
zinit load zdharma/history-search-multi-word

zinit ice wait"2" # load after 2 seconds
zinit load zdharma/history-search-multi-word

zinit ice wait    # also be used in `light` and `snippet`
zinit snippet https://gist.githubusercontent.com/hightemp/5071909/raw/
```

#### Lucid

Turbo mode is verbose, so you need an option for quiet.

You can use with `lucid`:

```zsh
zinit ice wait lucid
zinit load zdharma/history-search-multi-word
```

***F&A:*** What is `ice`?

`ice` is zinit's option command. The option melts like ice and is used only once.
(more: [Ice Modifiers](#ice-modifiers))

### Migration

#### Migration from Oh-My-ZSH

**Basic**

```zsh
zinit snippet <URL>        # Raw Syntax with URL
zinit snippet OMZ::<PATH>  # Shorthand OMZ/ (http://github.com/ohmyzsh/ohmyzsh/raw/master/)
zinit snippet OMZL::<PATH> # Shorthand OMZ/lib/
zinit snippet OMZT::<PATH> # Shorthand OMZ/themes/
zinit snippet OMZP::<PATH> # Shorthand OMZ/plugins/
```

**Library**

Importing the [clipboard](https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh) and [termsupport](https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/termsupport.zsh) Oh-My-Zsh Library Sample:

```zsh
# Raw Syntax
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/termsupport.zsh

# OMZ Shorthand Syntax
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/termsupport.zsh

# OMZL Shorthand Syntax
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::termsupport.zsh
```

**Theme**

To use **themes** created for Oh My Zsh you might want to first source the `git` library there.

Then you can use the themes as snippets (`zinit snippet <file path or GitHub URL>`).
Some themes require not only Oh My Zsh's Git **library**, but also Git **plugin** (error
about `current_branch` may appear). Load this Git-plugin as single-file
snippet directly from OMZ.

Most themes require `promptsubst` option (`setopt promptsubst` in `zshrc`), if it isn't set, then
prompt will appear as something like: `... $(build_prompt) ...`.

You might want to suppress completions provided by the git plugin by issuing `zinit cdclear -q`
(`-q` is for quiet) – see below **Ignoring Compdefs**.

To summarize:

```zsh
## Oh My Zsh Setting
ZSH_THEME="robbyrussell"

## Zinit Setting
# Must Load OMZ Git library
zinit snippet OMZL::git.zsh

# Load Git plugin from OMZ
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

# Load Prompt
zinit snippet OMZT::robbyrussell
```

External Theme Sample: [NicoSantangelo/Alpharized](https://github.com/nicosantangelo/Alpharized)

```zsh
## Oh My Zsh Setting
ZSH_THEME="alpharized"

## Zinit Setting
# Must Load OMZ Git library
zinit snippet OMZL::git.zsh

# Load Git plugin from OMZ
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

# Load Prompt
zinit light NicoSantangelo/Alpharized
```

***F&A:*** Error occurs when loading OMZ's theme.

If the `git` library will not be loaded, then similar to following errors will be appearing:

```zsh
........:1: command not found: git_prompt_status
........:1: command not found: git_prompt_short_sha
```

**Plugin**

If it consists of a single file, you can just load it.

```zsh
## Oh-My-Zsh Setting
plugins=(
  git
  dotenv
  rake
  rbenv
  ruby
)

## Zinit Setting
zinit snippet OMZP::git
zinit snippet OMZP::dotenv
zinit snippet OMZP::rake
zinit snippet OMZP::rbenv
zinit snippet OMZP::ruby
```

Use `zinit ice svn` if multiple files require an entire subdirectory.
Like [gitfast](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitfast), [osx](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/osx):

```zsh
zinit ice svn
zinit snippet OMZP::gitfast

zinit ice svn
zinit snippet OMZP::osx
```

Use `zinit ice as"completion"` to directly add single file completion snippets.
Like [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker), [fd](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fd):

```zsh
zinit ice as"completion"
zinit snippet OMZP::docker/_docker

zinit ice as"completion"
zinit snippet OMZP::fd/_fd
```

[You can see an extended explanation of Oh-My-Zsh setup in the Wiki](http://zdharma.github.io/zinit/wiki/Example-Oh-My-Zsh-setup/)

#### Migration from Prezto

**Basic**

```shell
zinit snippet <URL>        # Raw Syntax with URL
zinit snippet PZT::<PATH>  # Shorthand PZT/ (https://github.com/sorin-ionescu/prezto/tree/master/)
zinit snippet PZTM::<PATH> # Shorthand PZT/modules/
```

**Modules**

Importing the  [environment](https://github.com/sorin-ionescu/prezto/tree/master/modules/environment) and [terminal](https://github.com/sorin-ionescu/prezto/tree/master/modules/terminal) Prezto Modules Sample:

```zsh
## Prezto Setting
zstyle ':prezto:load' pmodule 'environment' 'terminal'

## Zinit Setting
# Raw Syntax
zinit snippet https://github.com/sorin-ionescu/prezto/blob/master/modules/environment/init.zsh
zinit snippet https://github.com/sorin-ionescu/prezto/blob/master/modules/terminal/init.zsh

# PZT Shorthand Syntax
zinit snippet PZT::modules/environment
zinit snippet PZT::modules/terminal

# PZTM Shorthand Syntax
zinit snippet PZTM::environment
zinit snippet PZTM::terminal
```

Use `zinit ice svn` if multiple files require an entire subdirectory.
Like [docker](https://github.com/sorin-ionescu/prezto/tree/master/modules/docker), [git](https://github.com/sorin-ionescu/prezto/tree/master/modules/git):

```zsh
zinit ice svn
zinit snippet PZTM::docker

zinit ice svn
zinit snippet PZTM::git
```

Use `zinit ice as"null"` if don't exist `*.plugin.zsh`, `init.zsh`, `*.zsh-theme*` files in module.
Like [archive](https://github.com/sorin-ionescu/prezto/tree/master/modules/archive):

```zsh
zinit ice svn as"null"
zinit snippet PZTM::archive
```

Use `zinit ice atclone"git clone <repo> <location>"` if module have external module.
Like [completion](https://github.com/sorin-ionescu/prezto/tree/master/modules/completion):

```shell
zplugin ice svn blockf \ # use blockf to prevent any unnecessary additions to fpath, as zinit manages fpath
            atclone"git clone --recursive https://github.com/zsh-users/zsh-completions.git external"
zplugin snippet PZTM::completion
```

***F&A:*** What is `zstyle`?

Read [zstyle](http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fzutil-Module) doc (more: [What does `zstyle` do?](https://unix.stackexchange.com/questions/214657/what-does-zstyle-do)).

### More Examples

After installing Zinit you can start adding some actions (load some plugins) to `~/.zshrc`, at bottom. Some examples:

```zsh
# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is actually not needed, Zinit will
# grep operating system name and architecture automatically when there's no `bpick'.
zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
zinit load docker/compose

# Vim repository on GitHub – a typical source code that needs compilation – Zinit
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH. You could also install the
# package under the path $ZPFX, see: http://zdharma.github.io/zinit/wiki/Compiling-programs
zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
    atpull"%atclone" make pick"src/vim"
zinit light vim/vim

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target.
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# Handle completions without loading any plugin, see "clist" command.
# This one is to be ran just once, in interactive session.
zinit creinstall %HOME/my_completions
```

```zsh
# For GNU ls (the binaries can be gls, gdircolors, e.g. on OS X when installing the
# coreutils package from Homebrew; you can also use https://github.com/ogham/exa)
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS
```

[You can see an extended explanation of LS_COLORS in the Wiki.](https://zdharma.github.io/zinit/wiki/LS_COLORS-explanation/)

```zsh
# make'!...' -> run make before atclone & atpull
zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zinit light direnv/direnv
```

[You can see an extended explanation of direnv in the Wiki.](https://zdharma.github.io/zinit/wiki/Direnv-explanation/)

If you're interested in more examples then check out the [zinit-configs
repository](https://github.com/zdharma/zinit-configs) where users have uploaded their
`~/.zshrc` and Zinit configurations. Feel free to
[submit](https://github.com/zdharma/zinit-configs/issues/new?template=request-to-add-zshrc-to-the-zinit-configs-repo.md)
your `~/.zshrc` there if it contains Zinit commands.

You can also check out the [Gallery of Zinit
Invocations](https://zdharma.github.io/zinit/wiki/GALLERY/) for some additional
examples.

Also, two articles on the Wiki present an example setup
[here](https://zdharma.github.io/zinit/wiki/Example-Minimal-Setup/) and
[here](https://zdharma.github.io/zinit/wiki/Example-Oh-My-Zsh-setup/).

# Completions

## Calling `compinit` Without Turbo Mode

With no Turbo mode in use, compinit can be called normally, i.e.: as `autoload compinit;
compinit`. This should be done after loading of all plugins and before possibly calling
`zinit cdreplay`.

The `cdreplay` subcommand is provided to re-play all catched `compdef` calls. The
`compdef` calls are used to define a completion for a command. For example, `compdef
_git git` defines that the `git` command should be completed by a `_git` function.

The `compdef` function is provided by `compinit` call. As it should be called later,
after loading all of the plugins, Zinit provides its own `compdef` function that
catches (i.e.: records in an array) the arguments of the call, so that the loaded
plugins can freely call `compdef`. Then, the `cdreplay` (*compdef-replay*) can be used,
after `compinit` will be called (and the original `compdef` function will become
available), to execute all detected `compdef` calls. To summarize:

```sh
source ~/.zinit/bin/zinit.zsh

zinit load "some/plugin"
...
compdef _gnu_generic fd  # this will be intercepted by Zinit, because as the compinit
                         # isn't yet loaded, thus there's no such function `compdef'; yet
                         # Zinit provides its own `compdef' function which saves the
                         # completion-definition for later possible re-run with `zinit
                         # cdreplay' or `zicdreplay' (the second one can be used in hooks
                         # like atload'', atinit'', etc.)
...
zinit load "other/plugin"

autoload -Uz compinit
compinit

zinit cdreplay -q   # -q is for quiet; actually run all the `compdef's saved before
                    #`compinit` call (`compinit' declares the `compdef' function, so
                    # it cannot be used until `compinit' is ran; Zinit solves this
                    # via intercepting the `compdef'-calls and storing them for later
                    # use with `zinit cdreplay')
```

This allows to call compinit once.
Performance gains are huge, example shell startup time with double `compinit`: **0.980** sec, with
`cdreplay` and single `compinit`: **0.156** sec.

## Calling `compinit` With Turbo Mode

If you load completions using `wait''` Turbo mode then you can add
`atinit'zicompinit'` to syntax-highlighting plugin (which should be the last
one loaded, as their (2 projects, [z-sy-h](https://github.com/zsh-users/zsh-syntax-highlighting) &
[f-sy-h](https://github.com/zdharma/fast-syntax-highlighting))
 documentation state), or `atload'zicompinit'` to last
completion-related plugin. `zicompinit` is a function that just runs `autoload
compinit; compinit`, created for convenience. There's also `zicdreplay` which
will replay any caught compdefs so you can also do: `atinit'zicompinit;
zicdreplay'`, etc. Basically, the whole topic is the same as normal `compinit` call,
but it is done in `atinit` or `atload` hook of the last related plugin with use of the
helper functions (`zicompinit`,`zicdreplay` & `zicdclear` – see below for explanation
of the last one). To summarize:

```zsh
source ~/.zinit/bin/zinit.zsh

# Load using the for-syntax
zinit wait lucid for \
    "some/plugin"
zinit wait lucid for \
    "other/plugin"

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
    zsh-users/zsh-completions
```

## Ignoring Compdefs

If you want to ignore compdefs provided by some plugins or snippets, place their load commands
before commands loading other plugins or snippets, and issue `zinit cdclear` (or
`zicdclear`, designed to be used in hooks like `atload''`):

```SystemVerilog
source ~/.zinit/bin/zinit.zsh
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided by Git plugin

zinit load "some/plugin"
...
zinit load "other/plugin"

autoload -Uz compinit
compinit
zinit cdreplay -q # <- execute compdefs provided by rest of plugins
zinit cdlist # look at gathered compdefs
```

The `cdreplay` is important if you use plugins like
`OMZP::kubectl` or `asdf-vm/asdf`, because these plugins call
`compdef`.

## Disabling System-Wide `compinit` Call (Ubuntu)

On Ubuntu users might get surprised that e.g. their completions work while they didn't
call `compinit` in their `.zshrc`. That's because the function is being called in
`/etc/zshrc`. To disable this call – what is needed to avoid the slowdown and if user
loads any completion-equipped plugins, i.e. almost on 100% – add the following lines to
`~/.zshenv`:

```zsh
# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
```
