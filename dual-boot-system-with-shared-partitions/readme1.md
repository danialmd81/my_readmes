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
