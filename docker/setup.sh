#!/usr/bin/env sh

if is_macos; then
  brew_install --cask docker-desktop
else
  # Linux: install Docker Engine via the system package manager
  pm=$(get_package_manager)
  case "$pm" in
    apt)
      # Use Docker's official apt repository for current versions
      install_system_packages ca-certificates curl

      sudo install -m 0755 -d /etc/apt/keyrings
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        -o /etc/apt/keyrings/docker.asc
      sudo chmod a+r /etc/apt/keyrings/docker.asc

      . /etc/os-release
      case "$ID" in
        debian | kali) docker_dist=debian ;;
        *) docker_dist=ubuntu ;;
      esac
      arch=$(dpkg --print-architecture)
      repo_line="deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.asc]"
      repo_line="$repo_line https://download.docker.com/linux/${docker_dist}"
      repo_line="$repo_line ${VERSION_CODENAME} stable"
      echo "$repo_line" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

      sudo apt-get update -qq
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
        docker-buildx-plugin docker-compose-plugin
      ;;
    pacman)
      install_system_packages docker docker-buildx docker-compose
      ;;
    dnf)
      install_system_packages docker docker-compose-plugin
      ;;
    zypper)
      install_system_packages docker docker-compose
      ;;
    *)
      log_error "Unsupported package manager: $pm. Supported: apt, pacman, dnf, zypper"
      exit 1
      ;;
  esac

  # Ensure the docker group exists and the current user is a member
  if ! getent group docker >/dev/null 2>&1; then
    sudo groupadd docker
  fi
  if ! id -nG "$(whoami)" | grep -qw docker; then
    sudo usermod -aG docker "$(whoami)"
    log "Added $(whoami) to docker group — re-login required"
  fi

  # Enable and start the Docker daemon via systemd
  if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl enable docker
    sudo systemctl start docker
  else
    log "Warning: systemctl not found; start the docker service manually"
  fi
fi
