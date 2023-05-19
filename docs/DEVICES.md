# Devices

## Epson

### Epson XP-330 series

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


