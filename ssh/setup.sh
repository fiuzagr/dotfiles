#!/usr/bin/env sh

if [ -f "$HOME/.ssh/id_rsa" ]; then
  if is_macos; then
    copy_cmd="pbcopy < ~/.ssh/id_rsa.pub"
  elif is_headless; then
    copy_cmd="cat ~/.ssh/id_rsa.pub"
  else
    copy_cmd="xclip -selection clipboard < ~/.ssh/id_rsa.pub"
  fi

  log "--------------------------------------------------------------------"
  log "RSA SSH KEY already exists. Skipping generation."
  log "run '$copy_cmd' to copy public key"
  log "--------------------------------------------------------------------"
else
  ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"

  if ! is_headless; then
    <"$HOME/.ssh/id_rsa.pub" tee /dev/tty | copy_to_clipboard
  fi

  if is_macos; then
    copy_cmd="pbcopy < ~/.ssh/id_rsa.pub"
  elif is_headless; then
    copy_cmd="cat ~/.ssh/id_rsa.pub"
  else
    copy_cmd="xclip -selection clipboard < ~/.ssh/id_rsa.pub"
  fi

  log "--------------------------------------------------------------------"
  log "New RSA SSH PUBLIC KEY copied to clipboard !!!"
  log "run '$copy_cmd' to copy it again"
  log "--------------------------------------------------------------------"
fi
