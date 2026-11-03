# bazzite-nix

- Bazzite desktop image for richese with Nvidia open kernel modules.
- Adds Hyprland, its desktop portal, lock and idle handling, Waybar, notifications, and launch utilities.
- Retains KDE Plasma as a fallback session.
- Provides `/nix` for the separate `~/dev/config` home configuration.

## Install

The `Build container image` GitHub Actions workflow publishes `ghcr.io/landaire/bazzite-nix:latest` after a change reaches `main`.

Apply the managed user configuration before entering Hyprland:

```console
cd ~/dev/config
nix run .#richese-switch
```

Switch to the published image and reboot:

```console
sudo bootc switch ghcr.io/landaire/bazzite-nix:latest
systemctl reboot
```

At SDDM, open the session chooser, select **Hyprland**, and sign in. SDDM remembers the selected session. Select **Plasma (Wayland)** there if Hyprland cannot start.

## Use Hyprland

The configuration lives in `~/dev/config/dotfiles`. After changing it, run `nix run .#richese-switch -- --home` from that repository, then run `hyprctl reload` in the active Hyprland session.

| Action | Binding |
| --- | --- |
| Open terminal | `Super+Enter` |
| Open launcher | `Super+Space` |
| Open Helium | `Super+B` |
| Open Dolphin | `Super+E` |
| Move focus | `Super+H/J/K/L` or arrow keys |
| Move window | `Super+Shift+H/J/K/L` |
| Resize window | `Super+Ctrl+H/J/K/L` |
| Select workspace | `Super+0..9` |
| Move window to workspace | `Super+Shift+0..9` |
| Toggle floating | `Super+V` |
| Toggle full screen | `Super+F` |
| Close window | `Super+Shift+Q` |
| Lock | `Super+Alt+L` |
| Exit Hyprland | `Super+Shift+E` |
| Copy a selected screenshot | `Print` |
| Copy a full screenshot | `Shift+Print` |

The configured display layout is `DP-2` at 3440x1440 and 174.963 Hz, followed by `HDMI-A-2` at 2560x1440 and 144.006 Hz with 1.7 scale. Unmatched displays use their preferred mode and automatic placement. Run `hyprctl monitors all` after changing cables or displays, then update `dotfiles/hypr/hyprland.lua`.

The session locks after 10 minutes and powers down displays after 15 minutes. Audio, network, and Bluetooth controls are available from Waybar.

## Verify

Inside Hyprland:

```console
printf 'desktop=%s session=%s\n' "$XDG_CURRENT_DESKTOP" "$XDG_SESSION_TYPE"
hyprctl monitors all
systemctl --user --no-pager status xdg-desktop-portal-hyprland.service
```

Expected session values are `Hyprland` and `wayland`. Screen sharing uses `xdg-desktop-portal-hyprland`.

## Update and recover

Bazzite stages image updates automatically. To request one immediately:

```console
sudo bootc upgrade
systemctl reboot
```

To return to the previous deployment:

```console
sudo bootc rollback
systemctl reboot
```

You can also select the prior deployment from the boot menu.

## Build locally

```console
just check
just build
```

`Containerfile` derives from `ghcr.io/ublue-os/bazzite-nvidia-open:stable`. Fedora retired its official Hyprland package. The image therefore uses the focused `nikromen/hyprland` COPR, which builds tagged upstream releases without network access and follows Fedora release branches. This remains a third-party system-package source. The COPR is disabled after package installation so it is not active on the installed host.
