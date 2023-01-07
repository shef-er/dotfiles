# Personal Arch Linux install guide

## 1. **Pre-installation**

### 1.1 **Set the console keyboard layout**

The default [console keymap](https://wiki.archlinux.org/title/Console_keymap) is US. Available layouts can be listed with:

```shell
ls /usr/share/kbd/keymaps/**/*.map.gz
```

To set the keyboard layout, pass a corresponding file name to [loadkeys(1)](https://man.archlinux.org/man/loadkeys.1), omitting path and file extension.

To set a Russian keyboard layout: 

```shell
loadkeys ru
```

[Console fonts](https://wiki.archlinux.org/title/Console_fonts) are located in `/usr/share/kbd/consolefonts/` and can likewise be set with [setfont(8)](https://man.archlinux.org/man/setfont.8). 

### 1.2 **Verify the boot mode**

To verify the boot mode, list the [efivars](https://wiki.archlinux.org/title/Efivars) directory: 

```shell
ls /sys/firmware/efi/efivars
```

If the command shows the directory without error, then the system is booted in UEFI mode. 

### 1.3 **Connect to the internet**

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

```shell
ping archlinux.org
```

> **Note:** In the installation image, [systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd), [systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved), [iwd](https://wiki.archlinux.org/title/Iwd) and [ModemManager](https://wiki.archlinux.org/title/ModemManager) are preconfigured and enabled by default. That will not be the case for the installed system.

### 1.4 **Update the system clock**

In the live environment [systemd-timesyncd](https://wiki.archlinux.org/title/Systemd-timesyncd) is enabled by default and time will be synced automatically once a connection to the internet is established.

Use [timedatectl(1)](https://man.archlinux.org/man/timedatectl.1) to ensure the system clock is accurate:

```shell
timedatectl status
```

### 1.5 **Partition the disks**

When recognized by the live system, disks are assigned to a [block device](https://wiki.archlinux.org/title/Block_device) such as `/dev/sda`, `/dev/nvme0n1` or `/dev/mmcblk0`. To identify these devices, use [lsblk](https://wiki.archlinux.org/title/Lsblk) or [fdisk](https://wiki.archlinux.org/title/Fdisk).

```
fdisk -l
```

Results ending in `rom`, `loop` or `airoot` may be ignored.

The following [partitions](https://wiki.archlinux.org/title/Partition) are **required** for a chosen device:

* One partition for the [root directory](https://en.wikipedia.org/wiki/Root_directory) `/`.
* For booting in [UEFI](https://wiki.archlinux.org/title/UEFI) mode: an [EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition).

If you want to create any stacked block devices for [LVM](https://wiki.archlinux.org/title/LVM), [system encryption](https://wiki.archlinux.org/title/Dm-crypt) or [RAID](https://wiki.archlinux.org/title/RAID), do it now.

Use [fdisk](https://wiki.archlinux.org/title/Fdisk) or [parted](https://wiki.archlinux.org/title/Parted) to modify partition tables. For example:

```shell
fdisk /dev/the_disk_to_be_partitioned
```

> Note:
> * If the disk does not show up, [make sure the disk controller is not in RAID mode](https://wiki.archlinux.org/title/Partitioning#Drives_are_not_visible_when_firmware_RAID_is_enabled).
> * If the disk from which you want to boot [already has an EFI system partition](https://wiki.archlinux.org/title/EFI_system_partition#Check_for_an_existing_partition), do not create another one, but use the existing partition instead.
> * [Swap](https://wiki.archlinux.org/title/Swap) space can be set on a [swap file](https://wiki.archlinux.org/title/Swap_file) for file systems supporting it.

### 1.5.1 **Example layout: UEFI with [GPT](https://wiki.archlinux.org/title/GPT)**

```
Mount point 	Partition 	                Partition type 	        Suggested size

/mnt/boot 	    /dev/efi_system_partition 	EFI system partition 	At least 300 MiB
[SWAP] 	        /dev/swap_partition 	    Linux swap 	            More than 512 MiB
/mnt 	        /dev/root_partition 	    Linux x86-64 root (/) 	Remainder of the device 
```

See also [Partitioning#Example layouts](https://wiki.archlinux.org/title/Partitioning#Example_layouts). 

### 1.6 **Format the partitions**

Once the partitions have been created, each newly created partition must be formatted with an appropriate [file system](https://wiki.archlinux.org/title/File_system).
See [File systems#Create a file system](https://wiki.archlinux.org/title/File_systems#Create_a_file_system) for details.

For example, to create an Ext4 file system labeled `ARCH_OS` on `/dev/root_partition`, use [mkfs.ext4](https://man.archlinux.org/man/mkfs.ext4.8):

```shell
mkfs.ext4 -L ARCH_OS /dev/root_partition
```

If you created a partition for [swap](https://wiki.archlinux.org/title/Swap), initialize it with [mkswap(8)](https://man.archlinux.org/man/mkswap.8):

```shell
mkswap /dev/swap_partition
```

If you created an EFI system partition, [format it](https://wiki.archlinux.org/title/EFI_system_partition#Format_the_partition) to FAT32 using [mkfs.fat(8)](https://man.archlinux.org/man/mkfs.fat.8).

> **Warning:** Only format the EFI system partition if you created it during the partitioning step. If there already was an EFI system partition on disk beforehand, reformatting it can destroy the boot loaders of other installed operating systems.

```shell
mkfs.fat -F 32 /dev/efi_system_partition
```

### 1.7 **Mount the file systems**

[Mount](https://wiki.archlinux.org/title/Mount) the root volume to `/mnt`. For example, if the root volume is `/dev/root_partition`:

```shell
mount /dev/root_partition /mnt
```

Create any remaining mount points (such as `/mnt/efi`) and mount their corresponding volumes. 

> **Tip:** Run [mount(8)](https://man.archlinux.org/man/mount.8) with the `--mkdir` option to create the specified mount point. Alternatively, create it using [mkdir(1)](https://man.archlinux.org/man/mkdir.1) beforehand.

For UEFI systems, mount the EFI system partition:

```shell
mount --mkdir /dev/efi_system_partition /mnt/boot
```

If you created a [swap](https://wiki.archlinux.org/title/Swap) volume, enable it with [swapon(8)](https://man.archlinux.org/man/swapon.8):

```shell
swapon /dev/swap_partition
```

[genfstab(8)](https://man.archlinux.org/man/genfstab.8) will later detect mounted file systems and swap space. 


## 2. **Installation**

Use the [pacstrap(8)](https://man.archlinux.org/man/pacstrap.8) script to install the [base](https://archlinux.org/packages/?name=base) package, Linux [kernel](https://wiki.archlinux.org/title/Kernel) and firmware for common hardware:

```shell
pacstrap -K /mnt base linux linux-firmware
```

> **Tip:**
> * You can substitute [linux](https://archlinux.org/packages/?name=linux) for a [kernel](https://wiki.archlinux.org/title/Kernel) package of your choice, or you could omit it entirely when installing in a [container](https://en.wikipedia.org/wiki/Container_(virtualization)).
> * You could omit the installation of the firmware package when installing in a virtual machine or container.

The [base](https://archlinux.org/packages/?name=base) package does not include all tools from the live installation, so installing other packages may be necessary for a fully functional base system.

In particular, consider installing:

* userspace utilities for the management of [file systems](https://wiki.archlinux.org/title/File_systems) that will be used on the system,
* utilities for accessing [RAID](https://wiki.archlinux.org/title/RAID) or [LVM](https://wiki.archlinux.org/title/LVM) partitions,
* specific firmware for other devices not included in [linux-firmware](https://archlinux.org/packages/?name=linux-firmware) (e.g. [sof-firmware](https://archlinux.org/packages/?name=sof-firmware) for [sound cards](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture#ALSA_firmware)),
* software necessary for [networking](https://wiki.archlinux.org/title/Networking), for example [NetworkManager](https://wiki.archlinux.org/title/Network_management) and [BlueZ](https://wiki.archlinux.org/title/bluetooth),
* a [text editor](https://wiki.archlinux.org/title/Text_editor), for example [nano](https://wiki.archlinux.org/title/nano) or [vim](https://wiki.archlinux.org/title/vim)
* packages for accessing documentation in [man](https://wiki.archlinux.org/title/Man) and [info](https://wiki.archlinux.org/title/Info) pages: [man-db](https://archlinux.org/packages/?name=man-db), [man-pages](https://archlinux.org/packages/?name=man-pages) and [texinfo](https://archlinux.org/packages/?name=texinfo).

To [install](https://wiki.archlinux.org/title/Install) other packages or package groups, append the names to the *pacstrap* command above (space separated) or use [pacman](https://wiki.archlinux.org/title/Pacman) while [chrooted into the new system](https://wiki.archlinux.org/title/Installation_guide#Chroot).

For comparison, packages available in the live system can be found in [pkglist.x86_64.txt](https://geo.mirror.pkgbuild.com/iso/latest/arch/pkglist.x86_64.txt).

Example set of essential packages:

```shell
pacman -S \
    sudo tree \
    fwupd linux-firmware-qcom linux-firmware-qlogic linux-firmware-whence alsa-firmware sof-firmware \
    networkmanager bluez-utils \
    nano vim \
    man-db man-pages texinfo
```

## 3. **Configure the system**

### 3.1 **Fstab**

Generate an [fstab](https://wiki.archlinux.org/title/Fstab) file (use `-U` or `-L` to define by [UUID](https://wiki.archlinux.org/title/UUID) or labels, respectively): 

```shell
genfstab -U /mnt >> /mnt/etc/fstab
```

Check the resulting `/mnt/etc/fstab` file, and [edit](https://wiki.archlinux.org/title/Textedit) it in case of errors. Also, you can add [corresponding](https://wiki.archlinux.org/title/Solid_state_drive#TRIM) mount options to extend your ssd lifespan.

### 3.2 **Chroot**

[Change root](https://wiki.archlinux.org/title/Change_root) into the new system:

```shell
arch-chroot /mnt
```

### 3.3 **Time zone**

Set the [time zone](https://wiki.archlinux.org/title/Time_zone): 

```shell
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Run [hwclock(8)](https://man.archlinux.org/man/hwclock.8) to generate `/etc/adjtime`:

```shell
hwclock --systohc
```

This command assumes the hardware clock is set to [UTC](https://en.wikipedia.org/wiki/UTC). See [System time#Time standard](https://wiki.archlinux.org/title/System_time#Time_standard) for details.

### 3.4 **Localization**


[Edit](https://wiki.archlinux.org/title/Textedit) `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8`, `ru_RU.UTF-8 UTF-8` and other needed [locales](https://wiki.archlinux.org/title/Locale).

Generate the locales by running:

```shell
locale-gen
```

[Create](https://wiki.archlinux.org/title/Create) the [locale.conf(5)](https://man.archlinux.org/man/locale.conf.5) file, and [set the LANG variable](https://wiki.archlinux.org/title/Locale#Setting_the_system_locale) accordingly.

Create `/etc/locale.conf` with the follwing content:

```shell
LANG=ru_RU.UTF-8
```

If you [set the console keyboard layout](https://wiki.archlinux.org/title/Installation_guide#Set_the_console_keyboard_layout), make the changes persistent in [vconsole.conf(5)](https://man.archlinux.org/man/vconsole.conf.5).

Create `/etc/vconsole.conf` with following content:

```shell
KEYMAP=ru
```

### 3.5 **Network configuration**

[Create](https://wiki.archlinux.org/title/Create) the [`/etc/hostname`](https://wiki.archlinux.org/title/Hostname) file:

```
myhostname
```

Complete the [network configuration](https://wiki.archlinux.org/title/Network_configuration) for the newly installed environment.
That may include installing suitable [network management](https://wiki.archlinux.org/title/Network_management) software.

For example, if you installed [bluez-utils](https://archlinux.org/packages/?name=bluez-utils), you can enable bluetooth:

```
systemctl enable --now bluetooth.service
```

### 3.6 **Root password**

Set the root password:

```shell
passwd
```

### 3.7 **Initramfs**

Creating a new *initramfs* is usually not required, because [mkinitcpio](https://wiki.archlinux.org/title/Mkinitcpio) was run on installation of the [kernel](https://wiki.archlinux.org/title/Kernel) package with *pacstrap*.

For [LVM](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM#Adding_mkinitcpio_hooks), [system encryption](https://wiki.archlinux.org/title/Dm-crypt) or [RAID](https://wiki.archlinux.org/title/RAID#Configure_mkinitcpio), modify [mkinitcpio.conf(5)](https://man.archlinux.org/man/mkinitcpio.conf.5) and recreate the initramfs image:

```shell
mkinitcpio -P
```

### 3.8 **Install microcode**

If you have an Intel or AMD CPU, enable [microcode](https://wiki.archlinux.org/title/Microcode) updates.

Install AMD microcode:

```shell
pacman -S amd-ucode
```

Or install Intel microcode:

```shell
pacman -S intel-ucode
```

### 3.9 **Boot loader**

Choose and install a Linux-capable [boot loader](https://wiki.archlinux.org/title/Boot_loader). For example [systemd-boot](https://wiki.archlinux.org/title/Systemd-boot).

### 3.9.1 systemd-boot

Use [bootctl(1)](https://man.archlinux.org/man/bootctl.1) to install systemd-boot to the [ESP mountpoint](https://wiki.archlinux.org/title/EFI_system_partition#Typical_mount_points) (e.g. `/efi` or `/boot`):

```
bootctl install
```

This will copy the *systemd-boot* EFI boot manager to the ESP: on an x64 architecture system `/usr/lib/systemd/boot/efi/systemd-bootx64.efi` will be copied to `esp/EFI/systemd/systemd-bootx64.efi` and `esp/EFI/BOOT/BOOTX64.EFI`, and *systemd-boot* will be set as the default EFI application. 

> **Note:**
> * When running `bootctl install`, `systemd-boot` will try to locate the ESP at `/efi`, `/boot`, and `/boot/efi`. Setting `esp` to a different location requires passing the `--esp-path=esp` option. (See [bootctl(1) § OPTIONS](https://man.archlinux.org/man/bootctl.1#OPTIONS) for details.)
> * Installing *systemd-boot* will overwrite any existing `esp/EFI/BOOT/BOOTX64.EFI`, e.g. Microsoft's version of the file.

The loader configuration is stored in the file `esp/loader/loader.conf`. See [loader.conf(5) § OPTIONS](https://man.archlinux.org/man/loader.conf.5#OPTIONS) for details.

> **Note:**
> If `options` is present in a boot entry and [Secure Boot](https://wiki.archlinux.org/title/Secure_Boot) is disabled, the value of `options` will override any `.cmdline` string embedded in the EFI image that is specified by `efi` or `linux` (see [Unified kernel image#Preparing a unified kernel image](https://wiki.archlinux.org/title/Unified_kernel_image#Preparing_a_unified_kernel_image)).
> With Secure Boot, however, `options` (and any edits made to the kernel command line in the bootloader UI) will be ignored, and only the embedded `.cmdline` will be used. 

An example of loader files launching Arch from a volume [labeled](https://wiki.archlinux.org/title/Persistent_block_device_naming#by-label) `ARCH_OS` and loading AMD CPU microcode is provided below.

Contents of `esp/loader/loader.conf`:

```
default arch.conf
timeout 3
editor no
#console-mode keep
```

Contents of `esp/loader/entries/arch.conf`:

```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root="LABEL=ARCH_OS" rw
```

Contents of `esp/loader/entries/arch-fallback.conf`:

```
title   Arch Linux Fallback
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux-fallback.img
options root="LABEL=ARCH_OS" rw
```

Use the `initrd` option to load the microcode, before the initial ramdisk. If not compiled into the kernel, microcode must be loaded by the early loader. It can be passed to the loader as part of a [unified kernel image](https://wiki.archlinux.org/title/Unified_kernel_image), or as an initrd image.

The latest microcode `cpu_manufacturer-ucode.img` must be available at boot time in your ESP. The ESP must be mounted as `/boot` in order to have the microcode updated every time [amd-ucode](https://archlinux.org/packages/?name=amd-ucode) or [intel-ucode](https://archlinux.org/packages/?name=intel-ucode) is updated.

> **Tip:**
> * The available boot entries which have been configured can be listed with the command `bootctl list`.
> * An example entry file is located at `/usr/share/systemd/bootctl/arch.conf`.
> * The [kernel parameters](https://wiki.archlinux.org/title/Kernel_parameters) for scenarios such as [LVM](https://wiki.archlinux.org/title/LVM), [LUKS](https://wiki.archlinux.org/title/LUKS) or [dm-crypt](https://wiki.archlinux.org/title/Dm-crypt) can be found on the relevant pages.

## 4. **Reboot**

Exit the chroot environment by typing `exit` or pressing `Ctrl+d`.

Optionally manually unmount all the partitions with `umount -R /mnt`: this allows noticing any "busy" partitions, and finding the cause with [fuser(1)](https://man.archlinux.org/man/fuser.1).

Finally, restart the machine by typing `reboot`: any partitions still mounted will be automatically unmounted by *systemd*. Remember to remove the installation medium and then login into the new system with the root account.

## 5. **Post-intallation**

See [README.md](README.md).