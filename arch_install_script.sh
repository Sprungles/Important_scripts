#!/bin/bash

echo "Arch Linux Installation Script"

# Autodetect available drives
echo "Available drives:"
lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac

# Prompt for drive selection
read -p "Enter the drive to use for installation (e.g., /dev/sda): " drive

# Prompt for UEFI or BIOS-based system
read -p "Is this a UEFI-based system? (y/n): " uefi

# Set the system clock
timedatectl set-ntp true

if [[ $uefi == "y" || $uefi == "Y" ]]; then
    echo "UEFI-based system"
    # Partition the disk
    parted "$drive" mklabel gpt
    parted "$drive" mkpart primary ext4 1MiB 100%
    parted "$drive" set 1 boot on

    # Format the partition as Ext4
    mkfs.ext4 -F "${drive}1"

    # Mount the partition
    mount "${drive}1" /mnt

    # Install essential packages
    pacstrap /mnt base linux linux-firmware

    # Generate the fstab file
    genfstab -U /mnt >> /mnt/etc/fstab

    # Copy the script to the new system
    cp $0 /mnt/script.sh

    # Change root into the new system
    arch-chroot /mnt /bin/bash -c "bash /script.sh chroot-uefi"
else
    echo "BIOS-based system"
    # Partition the disk
    parted "$drive" mklabel msdos
    parted "$drive" mkpart primary ext4 1MiB 100%
    parted "$drive" set 1 boot on

    # Format the partition as Ext4
    mkfs.ext4 -F "${drive}1"

    # Mount the partition
    mount "${drive}1" /mnt

    # Install essential packages
    pacstrap /mnt base linux linux-firmware

    # Generate the fstab file
    genfstab -U /mnt >> /mnt/etc/fstab

    # Copy the script to the new system
    cp $0 /mnt/script.sh

    # Change root into the new system
    arch-chroot /mnt /bin/bash -c "bash /script.sh chroot-bios"
fi

# Clean up the script
rm /mnt/script.sh

echo "Installation completed."

# Reboot countdown
echo -e "\n\n"
echo "Rebooting in 10 seconds. Press Enter to reboot now."

# Countdown
for i in {10..1}; do
    echo -ne "   \e[1m$i\e[0m"
    sleep 1
    echo -ne "\r"
done

echo -e "\n\nRebooting..."
reboot
x
