## 💊 install

```shell
## get last updates
sudo pacman -Syu

## shell tools
sudo pacman -S git git-lfs zsh zsh-autosuggestions zsh-completions btop
chsh -s /bin/zsh

## git config
git config --global user.name "Ernest Shefer"
git config --global core.editor nano
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --global core.filemode false
git config --global credential.helper cache
git config --global pull.rebase false
git config --global init.defaultBranch master
```

## ⏰ lang & time

```shell
localectl
timedatectl
```

## 🧠 hardware

### disable hw speaker

```shell
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf
```

### power optimization

```shell
## tlp
sudo pacman -S tlp tlp-rdw
sudo systemctl enable --now tlp.service
sudo systemctl enable --now NetworkManager-dispatcher.service

## set tlp settings: https://linrunner.de/tlp/settings/index.html
nano /etc/tlp.conf
sudo systemctl restart tlp.service
```

### ssd

```shell
sudo systemctl enable --now fstrim.service
```

extending ssd lifespan: `sudo nano /etc/fstab`:
* add btrfs options: `ssd,noatime`
* add ext4 options: `noatime`

### bluetooth

```shell
sudo pacman -S bluez-utils
sudo systemctl enable --now bluetooth.service
```

### cpu microcode

#### intel

```shell
sudo pacman -S intel-ucode
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

#### amd

```shell
sudo pacman -S linux-firmware
sudo grub-mkconfig -o /boot/grub/grub.cfg
```


## 💅 gnome shell

### packages

```shell
## gnome shell
sudo pacman -S \
  baobab \
  dconf-editor \
  eog \
  evince \
  file-roller \
  fragments \
  gdm \
  gedit \
  gnome-backgrounds \
  gnome-calculator \
  gnome-calendar \
  gnome-characters \
  gnome-clocks \
  gnome-color-manager \
  gnome-control-center \
  gnome-disk-utility \
  gnome-epub-thumbnailer \
  gnome-firmware \
  gnome-font-viewer \
  gnome-keyring \
  gnome-logs \
  gnome-menus \
  gnome-passwordsafe \
  gnome-remote-desktop \
  gnome-session \
  gnome-settings-daemon \
  gnome-shell \
  gnome-shell-extensions \
  gnome-shell-extension-appindicator \
  gnome-software \
  gnome-software-packagekit-plugin \
  gnome-system-monitor \
  gnome-terminal \
  gnome-tweaks \
  gnome-user-share \
  gnome-video-effects \
  gnome-weather \
  grilo-plugins \
  gvfs \
  gvfs-afc \
  gvfs-goa \
  gvfs-gphoto2 \
  gvfs-mtp \
  gvfs-nfs \
  gvfs-smb \
  mutter \
  nautilus \
  sushi \
  tracker3-miners \
  xdg-user-dirs-gtk

## daily driver
sudo pacman -S gimp inkscape rhythmbox picard
```

## 🔪 unwanted

```shell
sudo pacman -Rs xterm
sudo pacman -Rs pavucontrol
sudo pacman -Rs firewalld
sudo pacman -Rs stoken openconnect
sudo pacman -Rs arc-gtk-theme-eos eos-qogit-icons
```

### language switch

```
## using caps lock
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']"

## using shift + alt
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle', 'caps:none']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Alt_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"
```

### settings

```shell
## permamently disable tracker-miner-fs and free cache
gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
tracker3 reset --filesystem

## wise gnome tracker search index size 
gsettings set org.freedesktop.Tracker3.Extract max-bytes 10000

## tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

## gnome terminal
gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'light'

## disable ibus hotkeys
gsettings set org.freedesktop.ibus.panel.emoji hotkey "@as []"
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "@as []"
```

### fonts

```shell
sudo pacman -S ttf-jetbrains-mono
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'

gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'full'
```

### enable gdm tap-to-click

```shell
## enter root mode
sudo su

## switch to gdm user
su - gdm -s /bin/sh

export $(dbus-launch)
GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

## exit from the root user
exit

## restart machine or apply changes with
sudo systemctl restart gdm
```



## 🧰 development

```shell
## docker
sudo pacman -S docker docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER

## run to check is everything ok
docker run hello-world

## neovim
sudo pacman -S neovim wl-clipboard
git clone git@github.com:shef-er/nvim.git ~/.config/nvim

# code-oss
sudo pacman -S code
git clone git@github.com:shef-er/code.git "~/.config/Code - OSS"
```


## 🦊 firefox tweaks

### disable pocket

`about:config > extensions.pocket.enabled`
