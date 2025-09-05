# Setting Up Windows Boot Option in systemd-boot (Dual Boot: Windows & Linux, Separate EFI Partitions)

This guide will help you add a Windows boot option to **systemd-boot** on a computer that has both Windows and Linux installed, with each operating system using its own **EFI partition**.

---

## What is systemd-boot?

**systemd-boot** is a simple boot manager.  

- **Boot manager**: A program that lets you choose which operating system to start when you turn on your computer.
- **systemd-boot** is often used with Linux systems that use **systemd** (a system and service manager for Linux).

---

## What is an EFI partition?

An **EFI partition** (also called an **ESP** or EFI System Partition) is a special part of your hard drive.  

- It stores files needed to start (boot) your operating system.
- On dual-boot systems, sometimes Windows and Linux each use their own EFI partition.

---

## Steps to Add Windows Boot Option to systemd-boot

### 1. Find the Windows EFI Partition

First, you need to know which partition is used by Windows for its EFI files.

- Open a terminal in Linux.
- Run:

  ```bash
  sudo lsblk -f
  ```

  - **lsblk**: Lists all storage devices and their partitions.
  - Look for a partition with the **FAT32** filesystem and a label like "EFI" or "ESP".
  - If you see two, one is for Linux and one is for Windows. You can check which is which by mounting them and looking for a folder called `Microsoft`.

### 2. Mount the Windows EFI Partition

- Create a mount point:

  ```bash
  sudo mkdir /mnt/windows-efi
  ```

- Mount the Windows EFI partition (replace `sdXn` with the correct device, e.g., `sda1`):

  ```bash
  sudo mount /dev/sdXn /mnt/windows-efi
  ```

- Check for the `EFI/Microsoft/Boot` folder:

  ```bash
  ls /mnt/windows-efi/EFI/Microsoft/Boot
  ```

---

### 3. (Option 1) Use Windows EFI Partition Directly (Recommended)

You can point systemd-boot directly to the Windows EFI partition using its unique identifier (**PARTUUID**).

- Go to your Linux EFI partition's loader entries directory (usually `/boot/loader/entries/`):

  ```bash
  sudo nano /boot/loader/entries/windows.conf
  ```

- Add the following content (replace `sdXn` with your Windows EFI partition):

  ```ini
  title   Windows Boot Manager
  efi     /EFI/Microsoft/Boot/bootmgfw.efi
  options root=PARTUUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  ```

  - **title**: The name that will appear in the boot menu.
  - **efi**: The path to the Windows boot file on the Windows EFI partition.
  - **options root=PARTUUID=...**: This line tells systemd-boot to use the Windows EFI partition. Find the PARTUUID with:

    ```bash
    sudo blkid /dev/sdXn
    ```

---

### 4. (Option 2) Copy Windows Boot Files to Linux EFI Partition

If you prefer, you can copy the Windows boot files to your Linux EFI partition. This way, you don't need to use the `PARTUUID` option.

#### Steps

- Make sure both the Windows and Linux EFI partitions are mounted.  
  (Linux EFI is usually mounted at `/boot/efi`.)

- Copy the Windows boot folder to your Linux EFI partition:

  ```bash
  sudo cp -r /mnt/windows-efi/EFI/Microsoft /boot/efi/EFI/
  ```

- Now, create or edit the loader entry:

  ```bash
  sudo nano /boot/loader/entries/windows.conf
  ```

- Add the following content:

  ```ini
  title   Windows Boot Manager
  efi     /EFI/Microsoft/Boot/bootmgfw.efi
  ```

  - You do **not** need the `options root=PARTUUID=...` line in this case.

**Note:**  
If Windows updates its boot files, you may need to repeat the copy step.

---

### 5. Unmount the Windows EFI Partition

- When done, unmount:

  ```bash
  sudo umount /mnt/windows-efi
  ```

---

### 6. Reboot and Test

- Restart your computer.
- At the systemd-boot menu, you should see "Windows Boot Manager" as an option.

---

## Troubleshooting

- If Windows does not boot, double-check the EFI partition and the path to `bootmgfw.efi`.
- Make sure the Windows EFI partition is not encrypted or damaged.
- If you copied the files, repeat the copy step after major Windows updates.

---

## Glossary

- **EFI partition (ESP)**: Special disk area for boot files.
- **systemd-boot**: Simple boot menu for choosing operating systems.
- **bootmgfw.efi**: The Windows boot file.
- **PARTUUID**: A unique identifier for a disk partition.
- **mount**: Temporarily attach a disk partition to a folder so you can access its files.
- **unmount**: Detach a mounted partition.
- **loader entry**: A small text file that tells systemd-boot how to start an operating system.

---

**Tip:** If you ever update Windows, it might change its EFI files. If Windows stops booting, repeat these steps to check the EFI partition and update your systemd-boot entry or copy the files
