# Guide to Configuring `/etc/fstab` on Linux

## What is `/etc/fstab`?

`/etc/fstab` (File Systems Table) is a configuration file that tells Linux how and where to mount disk partitions and storage devices at boot.

## File Format

Each line in `/etc/fstab` describes a filesystem mount. The format is:

```
<file system>  <mount point>  <type>  <options>  <dump>  <pass>
```

### Example

```
UUID=948c2c5a-ea23-44b5-855a-f63354031a68 / ext4 noatime,errors=remount-ro 0 1
```

## Fields Explained

1. **file system**  
   - Device name, UUID, or PARTUUID (e.g., `/dev/sda1`, `UUID=...`)
   - Use `blkid` to list UUIDs:  

     ```
     sudo blkid
     ```

2. **mount point**  
   - Directory where the filesystem will be mounted (e.g., `/`, `/home`, `/mnt/data`)

3. **type**  
   - Filesystem type (e.g., `ext4`, `vfat`, `ntfs-3g`)

4. **options**  
   - Mount options (comma-separated, e.g., `defaults`, `noatime`, `ro`)
   - Common options:
     - `defaults`: Standard options
     - `noatime`: Don’t update file access times (improves performance)
     - `errors=remount-ro`: Remount as read-only on errors
     - `uid=1000,gid=1000`: Set owner/group (useful for NTFS/FAT)
     - `nofail`: Don’t fail boot if device is missing

5. **dump**  
   - Usually `0`. Used by `dump` backup tool.

6. **pass**  
   - Filesystem check order at boot.  
     - `0`: Don’t check  
     - `1`: Check first (usually `/`)  
     - `2`: Check after `/`

## Best Practices

- **Backup `/etc/fstab` before editing:**

  ```
  sudo cp /etc/fstab /etc/fstab.bak
  ```

- **Use UUIDs or PARTUUIDs** for reliability (devices may change names).
- **Test changes before rebooting:**

  ```
  sudo mount -a
  ```

  This mounts all filesystems in `/etc/fstab` (except swap) and shows errors.
- **Check for typos!** A mistake can prevent your system from booting.

## Real-World Example

```
UUID=948c2c5a-ea23-44b5-855a-f63354031a68 / ext4 noatime,errors=remount-ro 0 1
UUID=0F372DA92161ECCA /mnt/F ntfs-3g defaults,nofail,uid=1000,gid=1000 0 0
```

## Troubleshooting

- If you can’t boot, use a live USB to fix `/etc/fstab`.
- Mount your root partition and edit `/etc/fstab`:

  ```
  sudo mount /dev/sdXn /mnt
  sudo nano /mnt/etc/fstab
  ```

## More Resources

- `man fstab`
- [Arch Wiki: fstab](https://wiki.archlinux.org/title/fstab)
- [Ubuntu Docs: fstab](https://help.ubuntu.com/community/Fstab)

---

**Always double-check your changes and test with `sudo mount

## My `/etc/fstab` Configuration**

```
UUID=d431b8e1-7124-493f-99f2-c8fa9c1fb88f /home ext4 noatime,errors=remount-ro 0 0
PARTUUID=2fb146a3-58ce-4702-a449-f0047e3e154a /boot/efi vfat umask=0077 0 0
PARTUUID=0c1d37e0-98ba-4985-bc47-753386ff0601 /recovery vfat umask=0077 0 0
UUID=948c2c5a-ea23-44b5-855a-f63354031a68 / ext4 noatime,errors=remount-ro 0 1
UUID=0F372DA92161ECCA /mnt/F ntfs-3g defaults,nofail,uid=1000,gid=1000,windows_names,x-gvfs-show 0 0
UUID=E01AD08A1AD05F5A /mnt/E ntfs-3g defaults,nofail,uid=1000,gid=1000,windows_names,x-gvfs-show 0 0
UUID=60FA300AFA2FDB54 /mnt/D ntfs-3g defaults,nofail,uid=1000,gid=1000,windows_names,x-gvfs-show 0 0
```

---

### 1. **Concept Overview**

- **Partition Resizing**: Adjusting disk partitions to allocate more space to Windows (nvme0n1p3) and Linux root (nvme0n1p10) by shrinking adjacent data partitions (nvme0n1p5 and nvme0n1p6).
- **Why**: To optimize disk usage without reinstalling OSes.
- **Production Fit**: Common in dual-boot setups or when storage needs change.

---

### 2. **Implementation Details**

#### **Step-by-Step Instructions**

**A. Preparation**

- **Backup all important data** from affected partitions.
- **Create a Linux Live USB** (Ubuntu recommended).

**B. Boot into Live USB**

- Reboot and boot from the USB to ensure partitions are unmounted.

**C. Use GParted (Recommended GUI Tool)**

1. **Open GParted** (`sudo gparted`).
2. **Shrink nvme0n1p5 and nvme0n1p6:**
   - Right-click each partition → Resize/Move → Shrink from the end.
   - Apply changes.
3. **Move partitions if needed:**
   - If unallocated space is not adjacent to nvme0n1p3 or nvme0n1p10, move partitions so free space is next to the target partition.
4. **Expand nvme0n1p3 and nvme0n1p10:**
   - Right-click each → Resize/Move → Expand into adjacent unallocated space.
   - Apply changes.

**D. Resize Filesystems**

- **Windows (nvme0n1p3)**: Boot into Windows, run `chkdsk` and Disk Management to verify/expand filesystem.
- **Linux (nvme0n1p10)**: Boot into Linux, run:

  ```bash
  sudo resize2fs /dev/nvme0n1p10
  ```

  (for ext4; use appropriate tool for other filesystems)

---

### 3. **Best Practices**

- **Always backup before modifying partitions.**
- **Use a Live USB** to avoid mounted partitions.
- **Check filesystem integrity** after resizing (`chkdsk` for NTFS, `fsck` for ext4).
- **Document changes** for future troubleshooting.
- **Ensure partitions are properly aligned** for performance.

---

### 4. **Examples**

#### **ASCII Diagram**

**Before:**

```
| p3 (Win) | p4 | p5 | p6 | p7 (Linux) | ... | p10 (root) |
```

**After:**

```
| p3 (Win, expanded) | p4 | p5 (shrunk) | p6 (shrunk) | p7 | ... | p10 (root, expanded) |
```

#### **GParted Usage**

- Drag partition edges to resize.
- Move partitions to align free space.

#### **Real-World Scenario**

- Used in dual-boot laptops to allocate more space for Docker images on Linux or Windows updates.

---

**Summary:**  
Use GParted from a Live USB to shrink nvme0n1p5 and nvme0n1p6, move partitions if needed, then expand nvme0n1p3 and nvme0n1p10. Resize filesystems after expanding. No OS reinstall required.
