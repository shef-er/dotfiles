# System maintenance

Arch is a rolling release system and has rapid package turnover, so users have to take some time to do [system maintenance](https://wiki.archlinux.org/title/System_maintenance).

## Packages update

Before updating a system that has not been updated for more than a month, first of all update keyring

```shell
pacman -Sy archlinux-keyring
```

## Remove orphaned packages

```shell
pacman -Qdtq | pacman -Rns -
```
