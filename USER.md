## 1. **User preferences**

### 1.1 **Audio and video**

Wireplumber should be installed with `pipewire-alsa`, `pipewire-jack` and `pipewire-pulse` packages because it ships configuration that prompt media-session to activate PipeWire's audio features.

https://archlinux.org/news/undone-replacement-of-pipewire-media-session-with-wireplumber/

```shell
pacman -Sy \
    wireplumber \
    pipewire-jack \
    pipewire-alsa \
    pipewire-pulse
```

### 1.2 **Gnome shell**

```shell
pacman -Sy \
    gnome \
    gnome-firmware \
    gnome-passwordsafe \
    gnome-shell-extensions \
    gnome-shell-extension-appindicator \
    gnome-tweaks \
    gst-plugin-pipewire \
    xdg-desktop-portal-gnome \
    power-profiles-daemon \
    dconf-editor \
    celluloid \
    foliate \
    gnome-epub-thumbnailer \
    transmission-gtk \
    firefox \
    firefox-i18n-ru \
    libreoffice-fresh \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    qt5-wayland
```

If you want `gnome-software` to support PackageKit

```shell
pacman -Sy gnome-software-packagekit-plugin
```

## 2. **Applications**

### 2.1 **Important dependencies**

### 2.1.1 **AppImage support**

[Fuse](https://wiki.archlinux.org/title/FUSE) should be installed if you plan to use AppImage apps

```shell
pacman -Sy fuse
```
