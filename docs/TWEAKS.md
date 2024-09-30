# **Tweaks**

## **Disable hardware speaker**

```shell
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
```

## **Disable wifi power management**

```shell
sudo echo "[connection]\nwifi.powersave = 2" >> /etc/NetworkManager/conf.d/default-wifi-powersave-off.conf
```

## **Noise cancellation**

Create file `~/.config/pipewire/pipewire.conf.d/99-echo-cacnel.conf` with content:

```conf
context.modules = [
    {   
        name = libpipewire-module-echo-cancel
        args = {
            # Monitor mode: Instead of creating a virtual sink into which all
            # applications must play, in PipeWire the echo cancellation module can read
            # the audio that should be cancelled directly from the current fallback
            # audio output
            monitor.mode = true
            aec.args = {
                # Settings for the WebRTC echo cancellation engine
                webrtc.gain_control = true
                webrtc.extended_filter = false
                # Other WebRTC echo cancellation settings which may or may not exist
                # Documentation for the WebRTC echo cancellation library is difficult
                # to find
                #webrtc.analog_gain_control = false
                #webrtc.digital_gain_control = true
                #webrtc.experimental_agc = true
                webrtc.noise_suppression = true
            }
        }
    }
 ]
```

## **Remap cursed copilot key to Right Ctrl**

[Map scancodes to keycodes](https://wiki.archlinux.org/title/Map_scancodes_to_keycodes)

```shell
echo "evdev:name:AT Translated Set 2 keyboard:*\n KEYBOARD_KEY_6e=rightctrl" | sudo tee -a /etc/udev/hwdb.d/99-copilot-key.hwdb

sudo systemd-hwdb update
sudo udevadm trigger
```

<!--
One of side-effects, your `Super + LeftShift` combinations will yield `RightCtrl` key 

```shell
sudo pacman -Sy keyd

echo "[ids]\n*\n\n[main]\nleftmeta = layer(leftmeta)\n\n[leftmeta]\nleftshift = rightcontrol" | sudo tee /etc/keyd/default.conf

systemctl enable --now keyd.service
```
-->

## **Kernel**

```shell
echo "vm.dirty_writeback_centisecs=6000" >> /etc/sysctl.d/vm.conf
echo "vm.max_map_count=1048576" >> /etc/sysctl.d/vm.conf
```

## **GNOME**

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

Set [JetBrains Mono](https://www.jetbrains.com/lp/mono/) as default monospace font:

```shell
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 13'
```

### **GTK3 theme to match GTK4 apps**

Install [adw-gtk3](https://github.com/lassekongo83/adw-gtk3):

```shell
sudo pacman -Sy adw-gtk-theme
```

Change the theme to adw-gtk3 light:

```shell
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3' 
gsettings set org.gnome.desktop.interface color-scheme 'default'
```

## **TinySPARQL (Tracker)**

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

## **Power optimization**

[!] You can install [tlp](https://wiki.archlinux.org/title/TLP) package if you don't want to use [power-profiles-daemon](https://wiki.archlinux.org/title/CPU_frequency_scaling#power-profiles-daemon).

```shell
pacman -Sy tlp tlp-rdw
systemctl enable --now tlp.service
systemctl enable --now NetworkManager-dispatcher.service

# tlp settings: https://linrunner.de/tlp/settings/index.html
nano /etc/tlp.conf
systemctl restart tlp.service
```