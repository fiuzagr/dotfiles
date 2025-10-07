#!/usr/bin/env sh

if gpg --list-secret-keys | grep -q "sec"; then
  log 'GPG key already generated. Skipping...'
else
  sudo apt install -y gpg
  log 'Generating a new GPG key...'
  log

  log "Enter your name for the GPG key:"
  read -r NAME
  log "Enter your email for the GPG key:"
  read -r EMAIL
  log

  gpg --batch --generate-key <<EOF
%echo Generating a GPG key
Key-Type: RSA
Key-Length: 4096
Name-Real: $NAME
Name-Email: $EMAIL
Expire-Date: 0
%no-protection
%commit
%echo done
EOF
fi
