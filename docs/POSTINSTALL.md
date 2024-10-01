# Post-install

Refresh pacman database:

```shell
sudo pacman -Syu
```

Install [git](https://wiki.archlinux.org/title/git):

```shell
sudo pacman -Sy git git-lfs
```

Clone this repo to `~/.local/share/dotfiles`:

```shell
git clone '<this-repo-url>' ~/.local/share/dotfiles
```

Open dotfiles directory and link configs to `$HOME`:

```shell
(cd ~/.local/share/dotfiles && make link)
```

<!--
### **Zsh**

Install [zsh](https://wiki.archlinux.org/title/zsh) and make it your default shell

```shell
sudo pacman -Sy zsh zsh-autosuggestions zsh-completions
chsh -s /bin/zsh
```

After that relogin into your session.
-->

## **Ble.sh**

Install [ble.sh](https://wiki.archlinux.org/title/Bash#Syntax_highlighting_and_autosuggestions):

```shell
aur install blesh
```

<!--
```shell
BLESH_URL="https://github.com/akinomyoga/ble.sh/releases/download/v0.3.4/ble-0.3.4.tar.xz"
BLESH_DIR="$HOME/.local/share/blesh"
BLESH_TMP="/tmp/ble.tar.xz"
(curl -Lo "$BLESH_TMP" "$BLESH_URL"; mkdir -p "$BLESH_DIR"; cd "$BLESH_DIR"; tar xJf "$BLESH_TMP" --strip-components 1; rm "$BLESH_TMP")
```
-->

## **Essential applications**

Packages to install:

```shell
sudo pacman -Sy \
    htop
    obsidian \
    gnome-passwordsafe \
    seahorse \
    neovim

sudo pacman -Sy \
    firefox \
    firefox-i18n-ru \
    telegram-desktop \
    fragments \
    transmission-gtk

sudo pacman -Sy \
    libreoffice-fresh \
    gimp \
    inkscape \
    picard qt5-wayland
```

Install [Noto](https://fonts.google.com/noto) and [JetBrains Mono](https://www.jetbrains.com/lp/mono/) fonts:

```shell
sudo pacman -Sy noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono
```

Install [Flatpak](https://wiki.archlinux.org/title/Flatpak) and [flathub](https://flathub.org/) repository:

```shell
sudo pacman -Sy flatpak
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak --user install flathub \
    io.bassi.Amberol \
    com.valvesoftware.Steam \
    org.nickvision.tubeconverter
```

Install and enable [Syncthing](https://wiki.archlinux.org/title/Syncthing):

```shell
sudo pacman -Sy syncthing
systemctl --user enable --now syncthing.service
```

Packages to remove:

```shell
sudo pacman -Rs \
    epiphany \
    gnome-logs \
    gnome-music \
    gnome-photos \
    gnome-software \
    gnome-user-docs \
    yelp \
    totem
```

### 2.2 **AppImage**

AppImages require [FUSE](https://wiki.archlinux.org/title/FUSE) version 2 to run. Filesystem in Userspace (FUSE) is a system that lets non-root users mount filesystems.

```shell
pacman -Sy fuse
```
