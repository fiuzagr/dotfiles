#!/usr/bin/env sh

if [ -f "$HOME/.ssh/id_rsa" ]; then
  if is_macos; then
    copy_cmd="< ~/.ssh/id_rsa.pub tee /dev/tty | pbcopy"
  else
    copy_cmd="< ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard"
  fi

  log "--------------------------------------------------------------------"
  log "RSA SSH KEY already exists. Skipping generation."
  log "run '$copy_cmd' to copy public key"
  log "--------------------------------------------------------------------"
else
  ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"
  <"$HOME/.ssh/id_rsa.pub" tee /dev/tty | copy_to_clipboard

  if is_macos; then
    copy_cmd="< ~/.ssh/id_rsa.pub tee /dev/tty | pbcopy"
  else
    copy_cmd="< ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard"
  fi

  log "--------------------------------------------------------------------"
  log "New RSA SSH PUBLIC KEY copied to clipboard !!!"
  log "run '$copy_cmd' to copy it again"
  log "--------------------------------------------------------------------"
fi
