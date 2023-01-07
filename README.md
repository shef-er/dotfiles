## 💊 essentials

```shell
sudo pacman -Syu \
  git \
  git-lfs \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  htop
chsh -s /bin/zsh

git config --global user.name "<your name>"
git config --global user.email "<your email>"
git config --global core.editor nano
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --global core.filemode false
git config --global credential.helper cache
git config --global pull.rebase false
git config --global init.defaultBranch master
```

## 💅 gnome shell

```shell
sudo pacman -Syu \
  baobab \
  celluloid \
  dconf-editor \
  eog \
  evince \
  file-roller \
  flatpak \
  fragments \
  gdm \
  gnome-backgrounds \
  gnome-calculator \
  gnome-calendar \
  gnome-characters \
  gnome-clocks \
  gnome-color-manager \
  gnome-console \
  gnome-control-center \
  gnome-disk-utility \
  gnome-epub-thumbnailer \
  gnome-firmware \
  gnome-font-viewer \
  gnome-keyring \
  gnome-logs \
  gnome-passwordsafe \
  gnome-remote-desktop \
  gnome-session \
  gnome-settings-daemon \
  gnome-shell \
  gnome-shell-extensions \
  gnome-shell-extension-appindicator \
  gnome-software \
  gnome-system-monitor \
  gnome-text-editor \
  gnome-tweaks \
  gnome-user-share \
  gnome-weather \
  grilo-plugins \
  gvfs \
  gvfs-goa \
  gvfs-gphoto2 \
  gvfs-mtp \
  gvfs-nfs \
  nautilus \
  sushi \
  xdg-user-dirs-gtk

# some tools
sudo pacman -Sy \
  gimp \
  inkscape \
  picard

# daily driver
flatpak install flathub \
  io.bassi.Amberol \
  md.obsidian.Obsidian
```

### settings

```shell
# tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# caps lock to switch keyboard layout
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']"

# disable ibus hotkeys
gsettings set org.freedesktop.ibus.panel.emoji hotkey "@as []"
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"

# wise gnome tracker search index size 
gsettings set org.freedesktop.Tracker3.Extract max-bytes 10000

# permamently disable tracker-miner-fs and free cache
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
tracker3 reset --filesystem
```

### fonts

```shell
sudo pacman -Sy ttf-jetbrains-mono
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'

gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'full'
```

### enable gdm tap-to-click

```shell
# switch to gdm user
sudo su - gdm -s /bin/sh

export $(dbus-launch)
GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

# exit from the gdm user
exit

# restart system or apply changes with
sudo systemctl restart gdm
```


## 🧰 development

```shell
# docker
sudo pacman -Sy docker docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
docker run hello-world

# neovim
sudo pacman -Sy neovim wl-clipboard
git clone git@github.com:shef-er/nvim.git ~/.config/nvim

# code-oss
sudo pacman -Sy code
git clone git@github.com:shef-er/code.git "~/.config/Code - OSS"
```


## 🦊 firefox tweaks

### disable pocket

`about:config > extensions.pocket.enabled`
