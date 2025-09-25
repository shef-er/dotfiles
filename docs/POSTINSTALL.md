# Post-install

Login into your user account.

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

Install [Noto](https://fonts.google.com/noto) fonts:

```shell
sudo pacman -Sy noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

## **Settings**

### **Tap to click**

Enable tap to click for your current user:

```shell
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```

Enable tap to click for gdm user and restart GDM:

```shell
sudo machinectl shell gdm@ /bin/bash -c 'gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true'
sudo systemctl restart gdm
```

### **Use CapsLock as Ctrl key**

```shell
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
```

### **Monospaced font**

Set [Iosevka](https://typeof.net/Iosevka/) as default monospace font:

```shell
sudo pacman -Sy ttc-iosevka
gsettings set org.gnome.desktop.interface monospace-font-name 'Iosevka 14'
```

### **Install GTK3 theme to match GTK4 apps**

Install [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) and change the theme to `adw-gtk3` light:

```shell
sudo pacman -Sy adw-gtk-theme
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' 
gsettings set org.gnome.desktop.interface color-scheme 'default'
```

## **Applications**

Packages to install:

```shell
sudo pacman -Sy \
    fuse \
    htop \
    gvim \
    seahorse \
    secrets \
    fragments \
    libreoffice-fresh \
    foliate \
    gimp \
    inkscape \
    eartag \
    picard \
    qt5-wayland \
    gst-plugins-ugly
```

Packages to remove:

```shell
sudo pacman -Rs \
    epiphany \
    gnome-connections \
    gnome-contacts \
    gnome-logs \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour
```

Install [Flathub](https://flathub.org/) repository and some applications:

```shell
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak --user install flathub io.github.flattool.Warehouse
flatpak --user install flathub com.github.tchx84.Flatseal
flatpak --user install flathub com.google.Chrome
flatpak --user install flathub org.telegram.desktop
flatpak --user install flathub md.obsidian.Obsidian

flatpak --user install flathub com.valvesoftware.Steam

flatpak --user install flathub io.gitlab.theevilskeleton.Upscaler
flatpak --user install flathub org.nickvision.tubeconverter
flatpak --user install flathub me.iepure.devtoolbox
```

Install and enable [Syncthing](https://wiki.archlinux.org/title/Syncthing):

```shell
sudo pacman -Sy syncthing
systemctl --user enable --now syncthing.service
```
