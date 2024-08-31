# Devices

### **Nvidia**

For the [Maxwell (NV110/GMXXX)](https://nouveau.freedesktop.org/CodeNames.html#NV110) series and newer, install the [nvidia](https://archlinux.org/packages/?name=nvidia) package (for use with the [linux](https://archlinux.org/packages/?name=linux) kernel) or [nvidia-lts](https://archlinux.org/packages/?name=nvidia-lts) (for use with the [linux-lts](https://archlinux.org/packages/?name=linux-lts) kernel) package. 

Here are some settings for [Wayland](https://wiki.archlinux.org/title/NVIDIA#Wayland) support:

```shell
echo "options nvidia_drm modeset=1" > /etc/modprobe.d/nvidia-drm-modeset.conf
```

```shell
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/tmp" > /etc/modprobe.d/nvidia-power-management.conf
```

## **Epson**

### **Epson XP-330 series**

Install dependencies:

```shell
sudo pacman -Sy usbutils cups sane imagescan
```

Enable [CUPS](https://wiki.archlinux.org/title/CUPS) service:

```shell
sudo systemctl enable --now cups.service
```

Install [epson-inkjet-printer-escpr](https://aur.archlinux.org/packages/epson-inkjet-printer-escpr) from [AUR](https://wiki.archlinux.org/title/Arch_User_Repository)

Now you can try to see if sane recognizes your scanner. 

```shell
scanimage -L
```


