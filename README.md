## 💊 essentials

```shell
sudo pacman -Syu
```

```shell
sudo pacman -Sy zsh zsh-autosuggestions zsh-completions
chsh -s /bin/zsh
```

```shell
sudo pacman -Sy git git-lfs

git config --global user.name "<your name>"
git config --global user.email "<your email>"
```

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
  gimp inkscape \
  picard

flatpak install flathub \
  md.obsidian.Obsidian
```


## 💅 gnome shell

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

### fonts

```shell
sudo pacman -Sy ttf-jetbrains-mono
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'

gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'full'
```

### tap-to-click in gdm

```shell
# switch to gdm user
sudo machinectl shell gdm@ /bin/bash

gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# exit from the gdm user
exit

# restart system or apply changes with
sudo systemctl restart gdm
```


## 🔍 tracker

```shell
# wise gnome tracker search index size
gsettings set org.freedesktop.Tracker3.Extract max-bytes 10000

# permamently disable tracker-miner-fs and free cache
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
tracker3 reset --filesystem
```


## 🦊 firefox

### disable pocket

`about:config > extensions.pocket.enabled`


## 🐋 docker

```shell
sudo pacman -Sy docker docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
docker run hello-world
```
