#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Define packages to install
# To add a new package, simply add it to this array
PACKAGES=(
    autoconf
    bzip2
    bzip2-devel
    gcc
    gdbm-devel
    libffi-devel
    libuuid-devel
    libyaml-devel
    make
    mosh
    ncurses-devel
    neovim
    openssl-devel
    patch
    perl-FindBin
    plasma-workspace-x11
    python3-neovim
    readline-devel
    rust
    sqlite-devel
    tk-devel
    tmux
    zlib-ng-compat-devel
)

# Install all packages from fedora repos
dnf5 install -y "${PACKAGES[@]}"

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
