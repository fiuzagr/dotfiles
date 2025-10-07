#!/usr/bin/env sh

if [ -f "$HOME/.ssh/id_rsa" ]; then
  log "--------------------------------------------------------------------"
  log "RSA SSH KEY already exists. Skipping generation."
  log "run '< ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard' to copy public key"
  log "--------------------------------------------------------------------"
else
  ssh-keygen -t rsa -b 4096 -N "" -f "$HOME/.ssh/id_rsa"
  < "$HOME/.ssh/id_rsa.pub" tee /dev/tty | xclip -selection clipboard

  log "--------------------------------------------------------------------"
  log "New RSA SSH PUBLIC KEY copied to clipboard !!!"
  log "run '< ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard' to copy it again"
  log "--------------------------------------------------------------------"
fi
