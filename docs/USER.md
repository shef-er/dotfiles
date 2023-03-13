## 1. **User preferences**

Refresh pacman database

```shell
sudo pacman -Syu
```

### 1.1 **Gnome shell settings**

```shell
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# caps lock to switch keyboard layout
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']"

# disable ibus hotkeys
gsettings set org.freedesktop.ibus.panel.emoji hotkey "@as []"
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"

# (optional) To disable mouse middle click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
```

Install the best monospace font

```shell
sudo pacman -Sy ttf-jetbrains-mono
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'

gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'full'
```

### 1.1.1 **GDM settings**

Enable "Tap to click" in GDM

```shell
# switch to gdm user
sudo machinectl shell gdm@ /bin/bash

gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# exit from the gdm user
exit

# restart system or apply changes with
sudo systemctl restart gdm
```

### 1.1.2 **Tracker settings**

```shell
# wise gnome tracker search index size
gsettings set org.freedesktop.Tracker3.Extract max-bytes 10000

# permamently disable tracker-miner-fs and free cache
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
tracker3 reset --filesystem
```

### 1.2 **Shell**

Install [zsh](https://wiki.archlinux.org/title/zsh) and make it your default shell 

```shell
sudo pacman -Sy zsh zsh-autosuggestions zsh-completions
chsh -s /bin/zsh
```

### 1.3 **Git**

```shell
sudo pacman -Sy git git-lfs
```

## 2. **Applications**

### 2.1 **Important dependencies**

### 2.1.1 **AppImage support**

[Fuse](https://wiki.archlinux.org/title/FUSE) should be installed if you plan to use AppImage apps

```shell
pacman -Sy fuse
```

### 2.2 **Essentials**

```shell
# remove
sudo pacman -Rs \
    gnome-music \
    gnome-photos \
    gnome-user-docs \
    yelp \
    totem \
    cheese \
    gnome-video-effects

# install
sudo pacman -Sy \
    htop \
    firefox \
    firefox-i18n-ru \
    gnome-passwordsafe \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    transmission-gtk \
    celluloid \
    foliate \
    gnome-epub-thumbnailer \
    libreoffice-fresh \
    gimp inkscape \
    picard \
    qt5-wayland

flatpak install flathub \
    md.obsidian.Obsidian
```

### 2.3 **Preferences**

### 2.3.1 Firefox 🦊

Disable pocket `about:config > extensions.pocket.enabled = 0`

## 3. Development tools

### 3.1 Docker

```shell
sudo pacman -Sy docker docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
docker run hello-world
```