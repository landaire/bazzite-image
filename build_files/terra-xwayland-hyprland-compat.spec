Name: terra-xwayland-hyprland-compat
Version: 1
Release: 1%{?dist}
Summary: Architecture-qualified Xwayland capability for Hyprland
License: MIT
BuildArch: x86_64

Requires: terra-xorg-x11-server-Xwayland%{?_isa}
Provides: xorg-x11-server-Xwayland%{?_isa}

%description
Bazzite's Terra Xwayland package provides the Xwayland executable and an
unqualified compatibility capability. Hyprland's Fedora package requires the
same capability with an architecture qualifier. This package connects those
compatible RPM capabilities without replacing Bazzite's Xwayland build.

%files

%changelog
* Tue Nov 03 2026 bazzite-nix <hello@landaire.net> - 1-1
- Initial package
