# Base system installation

## 1. **Pre-installation**

### 1.1 **Connect to the internet**

To set up a network connection in the live environment, go through the following steps:

* Ensure your [network interface](https://wiki.archlinux.org/title/Network_interface) is listed and enabled, for example with [ip-link(8)](https://man.archlinux.org/man/ip-link.8):

```shell
ip link
```

* For wireless and WWAN, make sure the card is not blocked with [rfkill](https://wiki.archlinux.org/title/Rfkill).
* Connect to the network:
    * Ethernet—plug in the cable.
    * Wi-Fi—authenticate to the wireless network using [iwctl](https://wiki.archlinux.org/title/Iwctl).
    * Mobile broadband modem—connect to the mobile network with the [mmcli](https://wiki.archlinux.org/title/Mmcli) utility.

* The connection may be verified with [ping](https://wiki.archlinux.org/title/Ping):

For example, assuming your wireless device named `wlan0`:

```shell
iwctl station wlan0 connect <SSID>
```

Test your connection:

```shell
ping -с 3 archlinux.org
```

> **Note**  
> In the installation image, [systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd), [systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved), [iwd](https://wiki.archlinux.org/title/Iwd) and [ModemManager](https://wiki.archlinux.org/title/ModemManager) are preconfigured and enabled by default. That will not be the case for the installed system.

### 1.2 **Update the system clock**

In the live environment [systemd-timesyncd](https://wiki.archlinux.org/title/Systemd-timesyncd) is enabled by default and time will be synced automatically once a connection to the internet is established.

Use [timedatectl(1)](https://man.archlinux.org/man/timedatectl.1) to ensure the system clock is synchronized: 

```shell
timedatectl set-ntp true
timedatectl status
```

### 1.3 **Partition the disk**

When recognized by the live system, disks are assigned to a [block device](https://wiki.archlinux.org/title/Block_device) such as `/dev/sda`, `/dev/nvme0n1` or `/dev/mmcblk0`. To identify these devices, use [lsblk](https://wiki.archlinux.org/title/Lsblk).

```shell
lsblk -o +PARTLABEL
```

Results ending in `rom`, `loop` or `airoot` may be ignored.

The following [partitions](https://wiki.archlinux.org/title/Partition) are **required** for a chosen device:

* One partition for the [root directory](https://en.wikipedia.org/wiki/Root_directory) `/`.
* For booting in [UEFI](https://wiki.archlinux.org/title/UEFI) mode: an [EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition).

> **Warning**  
> If you want to create any stacked block devices do it now.

Given:
- `~1000G` - NVME SSD on `/dev/nvme0n1` device
- `16G` - RAM

Use [sgdisk](https://wiki.archlinux.org/title/GPT_fdisk) to modify partition tables.

```shell
export DRIVE=/dev/nvme0n1
```

Disk partition example:

```
Mount point     Partition number        Partition type          Suggested size

/mnt/boot       /dev/nvme0n1p1          EFI system partition    1G, or at least 550 MiB
[SWAP]          /dev/nvme0n1p2          Linux swap 	            32G, about 2*RAM size
/mnt            /dev/nvme0n1p3          Linux root (x86-64)     128G, or at least 23–32 GiB
/mnt/home       /dev/nvme0n1p4          Linux home              Remainder of the device
```

See also [Partitioning#Example layouts](https://wiki.archlinux.org/title/Partitioning#Example_layouts).

> **Tip**  
> On UEFI-booted systems, if specific conditions are met, [systemd-gpt-auto-generator(8)](https://man.archlinux.org/man/systemd-gpt-auto-generator.8) will automount GPT partitions following the [Discoverable Partitions Specification](https://uapi-group.org/specifications/specs/discoverable_partitions_specification/).

Zap the disk:

```
sgdisk --zap-all $DRIVE
```

> **Warning**  
> Zap (destroy) the GPT and MBR data structures and then exit. This option works much like -z, but as it wipes the MBR as well as the GPT, it's more  suitable  if  you  want  to repartition a disk after using this option, and completely unsuitable if you've already repartitioned the disk.

Create the partitions:

```shell
sgdisk --new=1:0:+1GiB   --typecode=1:ef00 --change-name=1:EFI $DRIVE
sgdisk --new=2:0:+32GiB  --typecode=2:8200 --change-name=2:swap $DRIVE
sgdisk --new=3:0:+128GiB --typecode=3:8304 --change-name=3:system $DRIVE
sgdisk --new=4:0:0       --typecode=4:8302 --change-name=4:home $DRIVE
```

> **Tip**  
> Use `sgdisk -L | less` to list all available partition type codes.

Check the partitions:

```shell
lsblk -o +PARTLABEL
```

Once the partitions have been created, each newly created partition must be formatted with an appropriate [file system](https://wiki.archlinux.org/title/File_system).
See [File systems#Create a file system](https://wiki.archlinux.org/title/File_systems#Create_a_file_system) for details.

[Format](https://wiki.archlinux.org/title/ EFI_system_partition#Format_the_partition) EFI system partition:

```shell
mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
```

> **Warning**  
> Only format the EFI system partition if you created it during the partitioning step. If there already was an EFI system partition on disk beforehand, reformatting it can destroy the boot loaders of other installed operating systems.

Format and mount root partition:

```shell
mkfs.ext4 -L system /dev/disk/by-partlabel/system
```

Format home partition:

```shell
mkfs.ext4 -L home /dev/disk/by-partlabel/home
```

Format and enable [swap](https://wiki.archlinux.org/title/Swap) partition:

```shell
mkswap -L swap /dev/disk/by-partlabel/swap
swapon -L swap
```

[Mount](https://wiki.archlinux.org/title/Mount) system partitions to `/mnt`:

```shell
mount -o noatime LABEL=system /mnt
mount -o noatime --mkdir LABEL=EFI /mnt/boot
mount -o noatime --mkdir LABEL=home /mnt/home
```

## 2. **Installation**

Use the [pacstrap(8)](https://man.archlinux.org/man/pacstrap.8) script to install the [base](https://archlinux.org/packages/?name=base) package, Linux [kernel](https://wiki.archlinux.org/title/Kernel) and firmware for common hardware:

```shell
pacstrap -K /mnt \
    base linux-lts linux-firmware dracut \
    base-devel \
    man-db man-pages \
    nano nano-syntax-highlighting
```

> **Tip**  
> * You can substitute [linux](https://archlinux.org/packages/?name=linux) for a [kernel](https://wiki.archlinux.org/title/Kernel) package of your choice, or you could omit it entirely when installing in a [container](https://en.wikipedia.org/wiki/Container_(virtualization)).
> * You could omit the installation of the firmware package when installing in a virtual machine or container.

The [base](https://archlinux.org/packages/?name=base) package does not include all tools from the live installation, so installing other packages may be necessary for a fully functional base system.

In particular, consider installing:

* userspace utilities for the management of [file systems](https://wiki.archlinux.org/title/File_systems) that will be used on the system,
* utilities for accessing [RAID](https://wiki.archlinux.org/title/RAID) or [LVM](https://wiki.archlinux.org/title/LVM) partitions,
* specific firmware for other devices not included in [linux-firmware](https://archlinux.org/packages/?name=linux-firmware) (e.g. [sof-firmware](https://archlinux.org/packages/?name=sof-firmware) for [sound cards](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture#ALSA_firmware)),
* a [text editor](https://wiki.archlinux.org/title/Text_editor), for example [nano](https://wiki.archlinux.org/title/nano) or [vim](https://wiki.archlinux.org/title/vim)
* packages for accessing documentation in [man](https://wiki.archlinux.org/title/Man) and [info](https://wiki.archlinux.org/title/Info) pages: [man-db](https://archlinux.org/packages/?name=man-db), [man-pages](https://archlinux.org/packages/?name=man-pages) and [texinfo](https://archlinux.org/packages/?name=texinfo).

To [install](https://wiki.archlinux.org/title/Install) other packages or package groups, append the names to the *pacstrap* command above (space separated) or use [pacman](https://wiki.archlinux.org/title/Pacman) while [chrooted into the new system](https://wiki.archlinux.org/title/Installation_guide#Chroot).

For comparison, packages available in the live system can be found in [pkglist.x86_64.txt](https://geo.mirror.pkgbuild.com/iso/latest/arch/pkglist.x86_64.txt).

Generate an [fstab](https://wiki.archlinux.org/title/Fstab) file (use `-U` or `-L` to define by [UUID](https://wiki.archlinux.org/title/UUID) or labels, respectively):

```shell
genfstab -L /mnt >> /mnt/etc/fstab
```

Check the resulting `/mnt/etc/fstab` file, and edit it in case of errors. Also, you can add [corresponding](https://wiki.archlinux.org/title/Solid_state_drive#TRIM) mount options to extend your ssd lifespan.

## 3. **Configure the system**

[Change root](https://wiki.archlinux.org/title/Change_root) into the new system:

```shell
arch-chroot /mnt
```

### 3.1 **Time**

Set the [time zone](https://wiki.archlinux.org/title/Time_zone), for example `Asia/Yekaterinburg`:

```shell
ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
```

Run [hwclock(8)](https://man.archlinux.org/man/hwclock.8) to generate `/etc/adjtime`:

```shell
hwclock --systohc
```

This command assumes the hardware clock is set to [UTC](https://en.wikipedia.org/wiki/UTC). See [System time#Time standard](https://wiki.archlinux.org/title/System_time#Time_standard) for details.

### 3.2 **Localization**

Edit `/etc/locale.gen` and uncomment or add your preffered locales and `en_US.UTF-8 UTF-8` which is commonly used as a fallback locale.

```shell
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
```

Generate the [locales](https://wiki.archlinux.org/title/Locale) by running:

```shell
locale-gen
```

Create the [locale.conf(5)](https://man.archlinux.org/man/locale.conf.5) file, and [set the LANG variable](https://wiki.archlinux.org/title/Locale#Setting_the_system_locale) accordingly.

Create `/etc/locale.conf` with the follwing content:

```shell
echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf
```

### 3.3 **Virtual console settings**

If you [set the console keyboard layout](https://wiki.archlinux.org/title/Installation_guide#Set_the_console_keyboard_layout), make the changes persistent in [vconsole.conf(5)](https://man.archlinux.org/man/vconsole.conf.5).

Available layouts can be listed with:

```shell
localectl list-keymaps
```

For example, create `/etc/vconsole.conf` with following content, to set a russian keyboard layout:

```shell
echo 'KEYMAP=ru' >> /etc/vconsole.conf
```

[Console fonts](https://wiki.archlinux.org/title/Console_fonts) are located in `/usr/share/kbd/consolefonts/` and can likewise be set with [setfont(8)](https://man.archlinux.org/man/setfont.8).

```shell
ls -l /usr/share/kbd/consolefonts/ | grep -i '.psfu.gz'
```

Add `FONT` variable to `/etc/vconsole.conf` according to your display density.  
For HiDPI displays:

```shell
echo 'FONT=latarcyrheb-sun32' >> /etc/vconsole.conf
```

Or, for low DPI displays:

```shell
echo 'FONT=latarcyrheb-sun16' >> /etc/vconsole.conf
```

### 3.4 **Network configuration**

Install software necessary for [networking](https://wiki.archlinux.org/title/Networking), like [NetworkManager](https://wiki.archlinux.org/title/Network_management) and [BlueZ](https://wiki.archlinux.org/title/bluetooth)

```shell
pacman -S \
    networkmanager iw wireless-regdb \
    bluez bluez-utils
```

Create the [hostname](https://wiki.archlinux.org/title/Hostname) file:

```shell
echo 'my-hostname' > /etc/hostname
```

Complete the [network configuration](https://wiki.archlinux.org/title/Network_configuration) for the newly installed environment.
That may include installing suitable [network management](https://wiki.archlinux.org/title/Network_management) software.

### 3.5 **Root password**

Set the root password:

```shell
passwd
```

### 3.6 **CPU Microcode**

Select your CPU architecture:

```shell
export CPU_ARCH=amd # amd or intel
```

Enable [microcode](https://wiki.archlinux.org/title/Microcode) updates.

```shell
pacman -S $CPU_ARCH-ucode
```

### 3.7 **systemd-boot**

To verify the boot mode, list the [efivars](https://wiki.archlinux.org/title/Efivars) directory:

```shell
ls /sys/firmware/efi/efivars
```

If the command shows the directory without error, then the system is booted in UEFI mode.

Choose and install a Linux-capable [boot loader](https://wiki.archlinux.org/title/Boot_loader). For example [systemd-boot](https://wiki.archlinux.org/title/Systemd-boot).

Use [bootctl(1)](https://man.archlinux.org/man/bootctl.1) to install systemd-boot to the [ESP mountpoint](https://wiki.archlinux.org/title/EFI_system_partition#Typical_mount_points), e.g. `/boot`:

```shell
bootctl install
```

This will copy the *systemd-boot* EFI boot manager to the ESP: on an x64 architecture system `/usr/lib/systemd/boot/efi/systemd-bootx64.efi` will be copied to `/boot/EFI/systemd/systemd-bootx64.efi` and `/boot/EFI/BOOT/BOOTX64.EFI`, and *systemd-boot* will be set as the default EFI application.

> **Note**  
> * When running `bootctl install`, `systemd-boot` will try to locate the ESP at `/efi`, `/boot`, and `/boot/efi`. (See [bootctl(1) § OPTIONS](https://man.archlinux.org/man/bootctl.1#OPTIONS) for details.)
> * Installing *systemd-boot* will overwrite any existing `esp/EFI/BOOT/BOOTX64.EFI`, e.g. Microsoft's version of the file.

The loader configuration is stored in the file `/boot/loader/loader.conf`. See [loader.conf(5) § OPTIONS](https://man.archlinux.org/man/loader.conf.5#OPTIONS) for details.

> **Note**  
> If `options` is present in a boot entry and [Secure Boot](https://wiki.archlinux.org/title/Secure_Boot) is disabled, the value of `options` will override any `.cmdline` string embedded in the EFI image that is specified by `efi` or `linux` (see [Unified kernel image#Preparing a unified kernel image](https://wiki.archlinux.org/title/Unified_kernel_image#Preparing_a_unified_kernel_image)).
> With Secure Boot, however, `options` (and any edits made to the kernel command line in the bootloader UI) will be ignored, and only the embedded `.cmdline` will be used.

Use the `initrd` option to load the microcode, before the initial ramdisk. If not compiled into the kernel, microcode must be loaded by the early loader. It can be passed to the loader as part of a [unified kernel image](https://wiki.archlinux.org/title/Unified_kernel_image), or as an initrd image.

The latest microcode `*-ucode.img` must be available at boot time in your ESP. The ESP must be mounted as `/boot` in order to have the microcode updated every time microcode is updated.

An example of loader files launching Arch from a volume [labeled](https://wiki.archlinux.org/title/Persistent_block_device_naming#by-label) `system` and loading AMD CPU microcode is provided below.

Contents of `/boot/loader/loader.conf`:

```
default arch-lts.conf
editor no
timeout 3
#console-mode keep
```

Contents of `/boot/loader/entries/arch-lts.conf`:

```
title   Arch Linux
linux   /vmlinuz-linux-lts
initrd  /amd-ucode.img
initrd  /initramfs-linux-lts.img
options root="LABEL=system" rw nmi_watchdog=0

```

Contents of `/boot/loader/entries/arch-lts-fallback.conf`:

```
title   Arch Linux Fallback
linux   /vmlinuz-linux-lts
initrd  /amd-ucode.img
initrd  /initramfs-linux-lts-fallback.img
options root="LABEL=system" rw nmi_watchdog=0

```

> **Tip**  
> * The available boot entries which have been configured can be listed with the command `bootctl list`.
> * An example entry file is located at `/usr/share/systemd/bootctl/arch.conf`.
> * The [kernel parameters](https://wiki.archlinux.org/title/Kernel_parameters) for scenarios such as [LUKS](https://wiki.archlinux.org/title/LUKS) or [dm-crypt](https://wiki.archlinux.org/title/Dm-crypt) can be found on the relevant pages.

## 3.8 **Reboot**

Optionally manually unmount all the partitions with 

```shell
umount -R /mnt
```

this allows noticing any "busy" partitions, and finding the cause with [fuser(1)](https://man.archlinux.org/man/fuser.1).

Exit the chroot environment by pressing `Ctrl+d` or typing

```shell
exit
```

Finally, restart the machine by typing

```shell
reboot
```

any partitions still mounted will be automatically unmounted by *systemd*. Remember to remove the installation medium and then login into the new system with the root account.

## 4. **Post-installation**

See [General recommendations](https://wiki.archlinux.org/title/General_recommendations) for system management directions and post-installation tutorials (like creating unprivileged user accounts, setting up a graphical user interface, sound or a touchpad).

For a list of applications that may be of interest, see [List of applications](https://wiki.archlinux.org/title/List_of_applications).

### 4.1 **Network connection**

Enable [NetworkManager](https://wiki.archlinux.org/title/NetworkManager):

```shell
systemctl enable --now NetworkManager.service
systemctl enable --now systemd-resolved.service
```

Connect to the network using `nmtui`

```shell
nmtui
```

Enable [Bluetooth](https://wiki.archlinux.org/title/Bluetooth):

```shell
systemctl enable --now bluetooth.service
```

### 4.2 **User**

A new installation leaves you with only the [superuser](https://en.wikipedia.org/wiki/Superuser) account, better known as "root". Logging in as root for prolonged periods of time, possibly even exposing it via [SSH](https://wiki.archlinux.org/title/SSH) on a server, [is insecure](https://apple.stackexchange.com/questions/192365/is-it-ok-to-use-the-root-user-as-a-normal-user/192422#192422). Instead, you should create and use unprivileged user account(s) for most tasks, only using the root account for system administration. See [Users and groups#User management](https://wiki.archlinux.org/title/Users_and_groups#User_management) for details.

Users and groups are a mechanism for *access control*; administrators may fine-tune group membership and ownership to grant or deny users and services access to system resources. Read the [Users and groups](https://wiki.archlinux.org/title/Users_and_groups) article for details and potential security risks. 

```shell
NEWUSER=<USERNAME>
```

To add a new user, use the `useradd` command: 

```shell
useradd -m -G sys,rfkill,wheel -s /bin/bash "$NEWUSER"
```

If you want to create user with existing home directory:

```shell
useradd -d /home/"$NEWUSER" -G sys,rfkill,wheel -s /bin/bash "$NEWUSER"
```

Set password for this user with [passwd](https://man.archlinux.org/man/passwd.1) command:

```
passwd "$NEWUSER"
```

### 4.3 **Security**

Read [Security](https://wiki.archlinux.org/title/Security) for recommendations and best practices on hardening the system.

For a list of applications to allow running commands or starting an interactive shell as another user (e.g. root), see [List of applications/Security#Privilege elevation](https://wiki.archlinux.org/title/List_of_applications/Security#Privilege_elevation).

Install the [sudo](https://archlinux.org/packages/?name=sudo) package.

```shell
pacman -S sudo
```

To allow members of group [wheel](https://wiki.archlinux.org/title/Wheel) sudo access, create `/etc/sudoers.d/wheel`:

```shell
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
```

> **Tip**  
> When creating new administrators, it is often desirable to enable sudo access for the `wheel` group and [add the user to it](https://wiki.archlinux.org/title/Users_and_groups#Group_management), since by default [Polkit](https://wiki.archlinux.org/title/Polkit#Administrator_identities) treats the members of the `wheel` group as administrators. If the user is not a member of `wheel`, software using Polkit may ask to authenticate using the root password instead of the user password.

### 4.4 **SSD**

The [util-linux](https://archlinux.org/packages/?name=util-linux) package provides `fstrim.service` and `fstrim.timer` [systemd](https://wiki.archlinux.org/title/Systemd) unit files. Enabling the timer will activate the service weekly. The service executes [fstrim(8)](https://man.archlinux.org/man/fstrim.8) on all mounted filesystems on devices that support the *discard* operation.

```shell
systemctl enable --now fstrim.timer
```

Also you can install [smartctl](https://wiki.archlinux.org/title/S.M.A.R.T.#smartctl) tool

```shell
pacman -Sy smartmontools
```

### 4.5 **CPU controls**

Install [power-profiles-daemon](https://wiki.archlinux.org/title/CPU_frequency_scaling#power-profiles-daemon):

```shell
pacman -Sy power-profiles-daemon
```

### 4.6 **Sound**

Install [PipeWire](https://wiki.archlinux.org/title/PipeWire) and [WirePlumber](https://wiki.archlinux.org/title/WirePlumber):

> **Tip**  
> Packages `pipewire-alsa`, `pipewire-pulse` and `pipewire-jack` ships configuration that prompt media-session to activate PipeWire's audio features.

```shell
pacman -Sy \
    sof-firmware \
    alsa-firmware \
    alsa-utils \
    pipewire \
    pipewire-jack \
    pipewire-alsa \
    pipewire-pulse \
    pipewire-audio \
    gst-plugin-pipewire \
    wireplumber
```

Enable services for current user:

```shell
systemctl --user enable pipewire pipewire-pulse
```

### 4.7 **Gnome shell**

```shell
pacman -Sy \
    gnome \
    webp-pixbuf-loader \
    gnome-shell-extensions \
    gnome-shell-extension-appindicator \
    dconf-editor
```

Enable [GDM](https://wiki.archlinux.org/title/GDM)

```shell
systemctl enable gdm.service
```

Restart the machine by typing:

```shell
reboot
```

### 5. **System maintenance**

See [MAINTENANCE.md](MAINTENANCE.md)
