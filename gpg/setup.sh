#!/usr/bin/env sh

if gpg --list-secret-keys | grep -q "sec"; then
  echo 'GPG key already generated. Skipping...' >&3
else
  sudo apt install -y gpg
  echo 'Generating a new GPG key...' >&3
  echo >&3

  echo "Enter your name for the GPG key:" >&3
  read -r NAME
  echo "Enter your email for the GPG key:" >&3
  read -r EMAIL
  echo >&3

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
