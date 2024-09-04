# **System maintenance**

Arch is a rolling release system and has rapid package turnover, so users have to take some time to do [system maintenance](https://wiki.archlinux.org/title/System_maintenance).

## **Disable hardware speaker**

```shell
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
```

## **Disable wifi power management**

```shell
sudo echo "[connection]\nwifi.powersave = 2" >> /etc/NetworkManager/conf.d/default-wifi-powersave-off.conf
```

### **Remap cursed copilot key to Right Ctrl**

[Map scancodes to keycodes](https://wiki.archlinux.org/title/Map_scancodes_to_keycodes)

```shell
echo "evdev:name:AT Translated Set 2 keyboard:*\n KEYBOARD_KEY_6e=rightctrl" | sudo tee -a /etc/udev/hwdb.d/99-copilot-key.hwdb

sudo systemd-hwdb update
sudo udevadm trigger
```

<!--
Only one side-effect, your `Super + LeftShift` combinations will yield `RightCtrl` key 

```shell
sudo pacman -Sy keyd

echo "[ids]\n*\n\n[main]\nleftmeta = layer(leftmeta)\n\n[leftmeta]\nleftshift = rightcontrol" | sudo tee /etc/keyd/default.conf

systemctl enable --now keyd.service
```
-->


## **Kernel tweaks**

```shell
echo "vm.dirty_writeback_centisecs=6000" >> /etc/sysctl.d/vm.conf
echo "vm.max_map_count=1048576" >> /etc/sysctl.d/vm.conf
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

## **Sound**

Check that Pipewire is installed correctly:

```shell
pactl info | grep Pipe
```

## **Pacman**

### **System update after a long break**

Before updating a system that has not been updated for more than a month, first of all update keyring

```shell
pacman -Sy archlinux-keyring
```

### **Enabling parallel package downloads**

Pacman 6.0 introduced the option to download packages in parallel. `ParallelDownloads` under `[options]` needs to be set to a positive integer in `/etc/pacman.conf` to use this feature (e.g., `5`). Packages will otherwise be downloaded sequentially if this option is unset.

### **Mirrors**

Visit the [Mirrors](https://wiki.archlinux.org/title/Mirrors) article for steps on taking full advantage of using the fastest and most up to date mirrors of the official repositories. As explained in the article, a particularly good advice is to routinely check the [Mirror Status](https://archlinux.org/mirrors/status/) page for a list of mirrors that have been recently synced. This can be automated with [Reflector](https://wiki.archlinux.org/title/Reflector). 


### **Cleaning the package cache**

Pacman stores its downloaded packages in `/var/cache/pacman/pkg/` and does not remove the old or uninstalled versions automatically.
This has some advantages:

* It allows to [downgrade](https://wiki.archlinux.org/title/Downgrade) a package without the need to retrieve the previous version through other means, such as the [Arch Linux Archive](https://wiki.archlinux.org/title/Arch_Linux_Archive).
* A package that has been uninstalled can easily be reinstalled directly from the cache directory, not requiring a new download from the repository.

However, it is necessary to deliberately clean up the cache periodically to prevent the directory to grow indefinitely in size.

The [paccache(8)](https://man.archlinux.org/man/paccache.8) script, provided within the [pacman-contrib](https://archlinux.org/packages/?name=pacman-contrib) package, deletes all cached versions of installed and uninstalled packages, except for the most recent three, by default:

```shell
paccache -r
```

Enable and start `paccache.timer` to discard unused packages weekly.

```shell
pacman -Sy pacman-contrib
systemctl enable --now paccache.timer
```

To remove all the cached packages that are not currently installed, and the unused sync database, execute:

```shell
pacman -Sc
```

To remove all files from the cache, use the clean switch twice, this is the most aggressive approach and will leave nothing in the cache directory:

```shell
pacman -Scc
```

### **Remove orphaned packages**

```shell
pacman -Qdtq | pacman -Rns -
```

## **Firewall**

A firewall can provide an extra layer of protection on top of the Linux networking stack. It is highly recommended to set up some form of firewall.

See [Category:Firewalls](https://wiki.archlinux.org/title/Category:Firewalls) for available guides.
