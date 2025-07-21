#!/usr/bin/env bash
set -xeuo pipefail

PACKAGES=(
    android-tools
    autoconf
    bcc
    bpftop
    bpftrace
    bzip2
    bzip2-devel
    ccache
    flatpak-builder
    gcc
    gdbm-devel
    libffi-devel
    libuuid-devel
    libyaml-devel
    make
    mosh
    ncurses-devel
    neovim
    nicstat
    numactl
    openssl-devel
    patch
    perl-FindBin
    plasma-workspace-x11
    podman-machine
    podman-tui
    python3-neovim
    qemu-kvm
    rclone
    readline-devel
    restic
    rust
    sqlite-devel
    sysprof
    tiptop
    tk-devel
    tmux
    zlib-ng-compat-devel
    zsh
)

# Remove plasma-workspace-x11 if IMAGE_BASE is set to bazzite-gnome
if [[ "${IMAGE_BASE:-}" == "bazzite-gnome" ]]; then
    echo "Removing plasma-workspace-x11 for bazzite-gnome image"
    # Create a new array without plasma-workspace-x11
    NEW_PACKAGES=()
    for pkg in "${PACKAGES[@]}"; do
        if [[ "$pkg" != "plasma-workspace-x11" ]]; then
            NEW_PACKAGES+=("$pkg")
        fi
    done
    PACKAGES=("${NEW_PACKAGES[@]}")
fi

# Install all packages from fedora repos
dnf5 install -y "${PACKAGES[@]}"

dnf5 install --enable-repo="copr:copr.fedorainfracloud.org:ublue-os:packages" -y \
    ublue-setup-services

docker_pkgs=(
    containerd.io
    docker-buildx-plugin
    docker-ce
    docker-ce-cli
    docker-compose-plugin
)
dnf5 config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo"
dnf5 config-manager setopt docker-ce-stable.enabled=0
dnf5 install -y --enable-repo="docker-ce-stable" "${docker_pkgs[@]}" || {
    # Use test packages if docker pkgs is not available for f42
    if (($(lsb_release -sr) == 42)); then
        echo "::info::Missing docker packages in f42, falling back to test repos..."
        dnf5 install -y --enablerepo="docker-ce-test" "${docker_pkgs[@]}"
    fi
}

# Load iptable_nat module for docker-in-docker.
# See:
#   - https://github.com/ublue-os/bluefin/issues/2365
#   - https://github.com/devcontainers/features/issues/1235
mkdir -p /etc/modules-load.d && cat >>/etc/modules-load.d/ip_tables.conf <<EOF
iptable_nat
EOF