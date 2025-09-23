#!/usr/bin/env sh

if [ -f ~/.ssh/id_rsa ]; then
  echo "--------------------------------------------------------------------" >&3
  echo "RSA SSH KEY already exists. Skipping generation." >&3
  echo "run '< ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard' to copy public key" >&3
  echo "--------------------------------------------------------------------" >&3
else
  ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
  < ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard

  echo "--------------------------------------------------------------------" >&3
  echo "New RSA SSH PUBLIC KEY copied to clipboard !!!" >&3
  echo "run '< ~/.ssh/id_rsa.pub tee /dev/tty | xclip -selection clipboard' to copy it again" >&3
  echo "--------------------------------------------------------------------" >&3
fi
