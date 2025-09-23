#!/usr/bin/env sh

# Append a line to .bashrc if it doesn't already exist
# $1 - file to test and append
# $2 - regex test OR line to append
# $3 - line to append (if $2 is regex test)
# Usages:
#   to_file '~/.bashrc' 'export PATH=$HOME/.local/bin:$PATH'
#   to_file '~/.bashrc' '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_file() {
  if [ ! -f "$1" ]; then
    echo "Error: First parameter should be a file" >&2
    exit 1
  fi
  if [ -z "$2" ]; then
    echo "Error: Second parameter cannot be empty" >&2
    exit 1
  fi

  if ! grep -q "$2" "$1"; then
    echo '' >> "$1"
    if [ -n "$3" ]; then
      echo "$3" >> "$1"
    else
      echo "$2" >> "$1"
    fi
  fi

  return
}

# Append a line to ~/.bashrc if it doesn't already exist
# $1 - regex test OR line to append
# $2 - line to append (if $1 is regex test)
# Usages:
#   to_bashrc 'export PATH=$HOME/.local/bin:$PATH'
#   to_bashrc '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_bashrc() {
  touch "$HOME/.bashrc"
  to_file "$HOME/.bashrc" "$1" "$2"
}
