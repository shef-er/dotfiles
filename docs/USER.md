## 1. **User preferences**

Refresh pacman database:

```shell
sudo pacman -Syu
```

Install [git](https://wiki.archlinux.org/title/git):

```shell
sudo pacman -Sy git git-lfs
```

And clone this repo to `~/.local/share/dotfiles`.

After that link dotfiles to `$HOME` dir:

```shell
cd ~/.local/share/dotfiles
make link
```

### 1.1 **Shell**

Install [zsh](https://wiki.archlinux.org/title/zsh) and make it your default shell 

```shell
sudo pacman -Sy zsh zsh-autosuggestions zsh-completions
chsh -s /bin/zsh
```

After that relogin into your user.

### 1.2 **Gnome settings**

Make CapsLock key to switch keyboard layout:

```shell
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']"
```

Disable IBus hotkeys:

```shell
gsettings set org.freedesktop.ibus.panel.emoji hotkey "@as []"
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"
```

If you want, you can disable mouse middle click paste:

```shell
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
```

Apply some font settings:

```shell
gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'full'
```

Install [JetBrains Mono](https://www.jetbrains.com/lp/mono/) and set as default monospace font:

```shell
sudo pacman -Sy ttf-jetbrains-mono
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'
```

### 1.2.1 **Enabling tap to click on laptop**

Enable tap to click for your current user:

```shell
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

After that login into shell as gdm user:

```shell
sudo machinectl shell gdm@ /bin/bash
```

Enable tap to click for gdm user:

```shell
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

Exit from the gdm user and apply GDM changes:

```shell
exit
sudo systemctl restart gdm
```

### 1.2.2 **Tracker settings**

Disable file indexing when running on battery:

```shell
gsettings set org.freedesktop.Tracker3.Miner.Files index-on-battery false
```

Reduce maximum number of UTF-8 bytes to extract:

```shell
gsettings set org.freedesktop.Tracker3.Extract max-bytes 10000
```

You can completely disable tracker file monitoring and reset tracker index:

```shell
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
tracker3 reset --filesystem
```

## 2. **Applications**

### 2.1 **Essentials**

```shell
# remove
sudo pacman -Rs \
    gnome-logs \
    gnome-music \
    gnome-photos \
    gnome-software \
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
    telegram-desktop \
    obsidian \
    gnome-passwordsafe \
    seahorse \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    transmission-gtk \
    celluloid \
    foliate \
    gnome-epub-thumbnailer \
    libreoffice-fresh \
    gimp \
    inkscape \
    picard \
    qt5-wayland

flatpak install flathub \
    com.github.unrud.VideoDownloader \
    org.gaphor.Gaphor
```

### 2.2 **AppImage support**

AppImages require [FUSE](https://wiki.archlinux.org/title/FUSE) version 2 to run. Filesystem in Userspace (FUSE) is a system that lets non-root users mount filesystems.

```shell
pacman -Sy fuse
```

## 3. Development tools

### 3.1 Docker

```shell
sudo pacman -Sy docker docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
docker run hello-world
```