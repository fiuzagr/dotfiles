#!/usr/bin/env sh

if is_linux; then
  # Install minimal build tools needed for Homebrew on Linux
  # These packages provide gcc, make, curl, file, git which Homebrew requires
  pm=$(get_package_manager)
  case "$pm" in
    apt)
      install_system_packages build-essential procps-ng curl file git
      ;;
    pacman)
      install_system_packages base-devel procps-ng curl file git
      ;;
    dnf)
      # Handle both Fedora-style (dnf group) and RHEL/CentOS style
      if command -v dnf >/dev/null 2>&1 && command -v dnf >/dev/null 2>&1 && ! command -v yum >/dev/null 2>&1; then
        # Modern Fedora with native dnf group support
        sudo dnf group install -y development-tools
        sudo dnf install -y procps-ng curl file git
      else
        # CentOS/RHEL or older Fedora
        sudo dnf groupinstall -y 'Development Tools'
        sudo dnf install -y procps-ng curl file git
      fi
      ;;
    zypper)
      install_system_packages gcc make gcc-c++ glibc curl file git
      ;;
    *)
      log_error "Unsupported package manager: $pm. Supported: apt (Debian/Ubuntu), pacman (Arch), dnf (Fedora/RHEL), zypper (openSUSE)"
      exit 1
      ;;
  esac
elif is_macos; then
  # Install Xcode Command Line Tools if not present
  if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools..."
    xcode-select --install
    log "Waiting for Xcode Command Line Tools installation..."
    until xcode-select -p >/dev/null 2>&1; do sleep 5; done
    log "Xcode Command Line Tools installation complete"
  else
    log "Xcode Command Line Tools already installed"
  fi
fi

