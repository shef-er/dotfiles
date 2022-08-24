## 💊 post-install

```shell
## get last updates
sudo pacman -Syu

## shell tools
sudo pacman -S git git-lfs zsh zsh-autosuggestions zsh-completions htop
chsh -s /bin/zsh

## git config
git config --global user.name "Ernest Shefer"
git config --global core.editor nano
git config --global core.autocrlf input
git config --global core.filemode false
git config --global credential.helper cache
git config --global pull.rebase false
git config --global init.defaultBranch master

## neovim
sudo pacman -S neovim wl-clipboard

## disable pc speaker kernel module (reboot after)
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf

## check time and language settings
localectl
timedatectl
```


## 🧠 hardware

### power optimization

```shell
sudo pacman -S tlp tlp-rdw
sudo systemctl enable --now tlp.service
sudo systemctl enable --now NetworkManager-dispatcher.service

## set up your tlp configuration
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
  eog \
  evince \
  file-roller \
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
  gnome-font-viewer \
  gnome-keyring \
  gnome-logs \
  gnome-menus \
  gnome-remote-desktop \
  gnome-session \
  gnome-settings-daemon \
  gnome-shell \
  gnome-shell-extensions \
  gnome-shell-extension-appindicator \
  gnome-software \
  gnome-system-monitor \
  gnome-terminal \
  gnome-user-share \
  gnome-video-effects \
  gnome-weather \
  grilo-plugins \
  gvfs \
  gvfs-afc \
  gvfs-goa \
  gvfs-google \
  gvfs-gphoto2 \
  gvfs-mtp \
  gvfs-nfs \
  gvfs-smb \
  mutter \
  nautilus \
  sushi \
  tracker3-miners \
  xdg-user-dirs-gtk \
  dconf-editor \
  devhelp \
  gnome-tweaks
```

### settings

```shell
## tap to click
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true

## keyboard
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle', 'caps:none']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Alt_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"

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

### gdm tap-to-click

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


## 💡 usefull apps

```shell
sudo pacman -S transmission-gtk gimp inkscape rhythmbox picard
```


## 🔪 unwanted apps

```shell
sudo pacman -Rs xterm
sudo pacman -Rs pavucontrol
sudo pacman -Rs firewalld
sudo pacman -Rs stoken openconnect
sudo pacman -Rs arc-gtk-theme-eos eos-qogit-icons
```


## 🧰 development

```shell
## vpn
sudo pacman -S networkmanager-fortisslvpn

## docker
sudo pacman -S docker docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER

## run to check is everything ok
docker run hello-world
```

