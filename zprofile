#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='vim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
# Set the list of directories that Zsh searches for programs.
path=(
  $gopath/bin
  /usr/local/opt/curl/bin
  /usr/local/{bin,sbin}
  /usr/local/go/bin
  /usr/local/opt/gettext/bin
  /usr/local/opt/bison/bin
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

TMPPREFIX="$(mktemp -d)/zsh"

if command -v /opt/homebrew/bin/brew &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
