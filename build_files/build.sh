#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

#systemctl enable podman.socket

### Helium browser (Chromium fork) from the upstream COPR.
# Baked in so it no longer needs rpm-ostree layering on the host, which would
# otherwise block `bootc upgrade`.
# helium-bin unpacks into /opt/helium. On ublue images /opt is a symlink to
# /var/opt (empty at build time), so the rpm unpack fails to create the dir.
# Replace it with a real directory, making /opt image-immutable.
if [ -L /opt ]; then
  rm /opt
  mkdir /opt
fi

dnf5 -y copr enable imput/helium
dnf5 -y install helium-bin
dnf5 -y copr disable imput/helium

dnf5 -y copr enable lizardbyte/stable
dnf5 -y install Sunshine
dnf5 -y copr disable lizardbyte/stable

### nix Mountpoint
mkdir -p /nix
