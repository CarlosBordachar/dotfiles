# dotFiles

Personal dotFiles.

## Workspaces

Not all of them are necessary for a functional workspace.

### Base

- Bash
- [bat](https://github.com/sharkdp/bat)
- [btop](https://github.com/aristocratos/btop)
- [delta](https://github.com/dandavison/delta)
- [fzf](https://github.com/junegunn/fzf)
- [git](https://github.com/git/git)
- [MPV](https://github.com/mpv-player/mpv)
- [Neovim](https://github.com/neovim/neovim)
- [Starship](https://github.com/starship/starship)
- Scripts:
  - [fzf-git.sh](https://github.com/junegunn/fzf-git.sh)

### BSPWM

- Window Manager: [bspwm](https://github.com/baskerville/bspwm)
- Hotkey Daemon: [sxhkd](https://github.com/baskerville/sxhkd)
- Launcher: [Rofi](https://github.com/davatorium/rofi)
- Panel: [Polybar](https://github.com/polybar/polybar)
- Notification: [Dunst](https://github.com/dunst-project/dunst)
- Terminal: [Xfce4 Terminal](https://gitlab.xfce.org/apps/xfce4-terminal)
- File Manager: [Thunar](https://gitlab.xfce.org/xfce/thunar)
- System Monitor: [Conky](https://github.com/brndnmtthws/conky)
- Compositor (transparency): [Picom](https://github.com/yshui/picom)

### Niri

- Window Manager (compositor): [niri](https://github.com/niri-wm/niri)
- Launcher: [Fuzzel](https://codeberg.org/dnkl/fuzzel)
- Shell: [noctalia](https://github.com/noctalia-dev/noctalia-shell)
- Terminal: [foot](https://codeberg.org/dnkl/foot)

### KDE

- Desktop Environment: [Plasma Desktop](https://github.com/KDE/plasma-desktop)
- Terminal: [Konsole](https://github.com/KDE/konsole)
- File Manager: [dolphin](https://github.com/KDE/dolphin)

### Terminals

- [Alacritty](https://github.com/alacritty/alacritty)
- [foot](https://codeberg.org/dnkl/foot)
- [Konsole](https://github.com/KDE/konsole)
- [Terminator](https://github.com/gnome-terminator/terminator)
- [Xfce4 Terminal](https://gitlab.xfce.org/apps/xfce4-terminal)

### Develop

- [Godot](https://github.com/godotengine/godot)
- [VS Codium](https://github.com/VSCodium/vscodium)

### Utils

- PDF Reader : [zathura](https://github.com/pwmt/zathura) with zathura-pdf-poppler pluging

## How to use

Apply configs using `stow` command line app, generating symbolic links.

### Steps

#### 1. Clone this repository at home (~):

```shell
cd ~
git clone --branch stow git@github.com:CarlosBordachar/dotfiles.git
```

#### 2. Generate symlinks.

```shell
cd dotfiles
stow appName
```

This will generate the symlink in the destination folder defined inside the appName's directory.

> [!WARNING]
> Final destination directory may not exists, to generate the appropriate symlink.

#### 3. Remove symlinks [optional]

```shell
cd dotfiles
stow -D appName
```

This will remove the symlink in the destination folder defined inside the appName's directory.


