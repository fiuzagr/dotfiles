#!/usr/bin/env sh

log 'Installing git, gh, and gnupg...'
brew_install git
brew_install gh
brew_install gnupg

touch "$HOME/.gitconfig"

log 'Configuring git includes...'
git config --global include.path "$DOTFILES_PATH/git/gitconfig"
git config --global core.excludesfile "$DOTFILES_PATH/git/gitignore"
git config --global init.templatedir "$DOTFILES_PATH/git/git_template"

if ! git config --global user.name >/dev/null 2>&1 || \
   ! git config --global user.email >/dev/null 2>&1; then
  log
  log "Enter your name for GIT:"
  while [ -z "$NAME" ]; do
    IFS= read -r NAME </dev/tty || exit 1
  done

  log "Enter your email OR GitHub username for GIT:"
  while [ -z "$EMAIL" ]; do
    IFS= read -r EMAIL </dev/tty || exit 1
  done
  log

  case "$EMAIL" in
    *@*) ;;
    *) EMAIL="${EMAIL}@users.noreply.github.com" ;;
  esac

  git config --global user.name "$NAME"
  git config --global user.email "$EMAIL"
fi

GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if ! gpg --list-secret-keys "$GIT_EMAIL" 2>/dev/null | grep -q "sec"; then
  log
  log "Enter a passphrase for your GPG key:"
  _gp_stty=$(stty -g </dev/tty 2>/dev/null)
  stty -echo </dev/tty 2>/dev/null
  IFS= read -r GPG_PASSPHRASE </dev/tty || {
    stty "$_gp_stty" </dev/tty 2>/dev/null
    exit 1
  }
  stty "$_gp_stty" </dev/tty 2>/dev/null
  log
  log "Confirm passphrase:"
  stty -echo </dev/tty 2>/dev/null
  IFS= read -r GPG_PASSPHRASE_CONFIRM </dev/tty || {
    stty "$_gp_stty" </dev/tty 2>/dev/null
    exit 1
  }
  stty "$_gp_stty" </dev/tty 2>/dev/null
  log

  if [ "$GPG_PASSPHRASE" != "$GPG_PASSPHRASE_CONFIRM" ]; then
    log_error "Passphrases do not match."
    exit 1
  fi

  log 'Generating Ed25519 GPG key for Git signing...'
  gpg --batch --generate-key <<EOF
%echo Generating GPG key for Git signing
Key-Type: eddsa
Key-Curve: Ed25519
Key-Usage: cert
Subkey-Type: eddsa
Subkey-Curve: Ed25519
Subkey-Usage: sign
Name-Real: $GIT_NAME
Name-Email: $GIT_EMAIL
Expire-Date: 3y
Passphrase: $GPG_PASSPHRASE
%commit
%echo done
EOF

  unset GPG_PASSPHRASE GPG_PASSPHRASE_CONFIRM
  log 'GPG key generated.'
fi

mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"

to_file "$HOME/.gnupg/gpg-agent.conf" \
  "default-cache-ttl" "default-cache-ttl 43200"
to_file "$HOME/.gnupg/gpg-agent.conf" \
  "max-cache-ttl" "max-cache-ttl 43200"

gpgconf --kill gpg-agent 2>/dev/null || true
gpgconf --launch gpg-agent 2>/dev/null || true

if ! git config --global user.signingkey >/dev/null 2>&1; then
  SIGNING_KEY=$(gpg --list-secret-keys --with-colons 2>/dev/null \
    | grep '^fpr:' | tail -1 | cut -d: -f10)
  if [ -n "$SIGNING_KEY" ]; then
    git config --global user.signingkey "$SIGNING_KEY"
    log "Signing key configured: $SIGNING_KEY"
  fi
fi

log
log "Add your GPG public key to GitHub for verified commits:"
log "  gpg --armor --export $SIGNING_KEY"
log
