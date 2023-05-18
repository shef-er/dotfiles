## 1. **User preferences**

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
cd ~/.local/share/dotfiles
make link
```

### 1.1 **Shell**

Install [zsh](https://wiki.archlinux.org/title/zsh) and make it your default shell 

```shell
sudo pacman -Sy zsh zsh-autosuggestions zsh-completions
chsh -s /bin/zsh
```

After that relogin into your session.

### 1.2 **Gnome settings**

### 1.2.1 **Tap to click**

Enable tap to click for your current user:

```shell
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

Enable tap to click for gdm user and restart GDM:

```shell
sudo machinectl shell gdm@ /bin/bash -c 'gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true'
sudo systemctl restart gdm
```

### 1.2.2 **Use CapsLock as Compose or Ctrl key**

```shell
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'compose:caps']"
```

### 1.2.3 **Monospace font**

Install [JetBrains Mono](https://www.jetbrains.com/lp/mono/) and set it as default monospace font:

```shell
sudo pacman -Sy ttf-jetbrains-mono
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'
```

### 1.2.4 **Tracker settings**

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

### 1.2.5 **IBus settings (optional and questionable)**

Install the [ibus](https://archlinux.org/packages/?name=ibus) package.

```shell
pacman -Sy ibus
```

Disable [IBus](https://wiki.archlinux.org/title/IBus) emoji hotkeys:

```shell
gsettings set org.freedesktop.ibus.panel.emoji hotkey "@as []"
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"
```

## 2. **Applications**

### 2.1 **Essentials**

Packages to install:

```shell
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

Packages to remove:

```shell
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
```

### 2.2 **AppImage**

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