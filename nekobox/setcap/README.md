# Setting, Listing, and Removing `setcap` on Nekobox

This guide explains how to use Linux capabilities (`setcap`) with the Nekobox binary. Capabilities allow you to grant specific privileges to executables without running them as root.

## 1. Setting `setcap` on Nekobox

To allow Nekobox to bind to privileged ports (e.g., ports < 1024) without root, you can grant the `cap_net_bind_service` capability:

```bash
sudo setcap cap_net_admin,cap_net_bind_service=+ep /path/to/nekobox
```

- Replace `/path/to/nekobox` with the actual path to your Nekobox binary.

## 2. Listing Capabilities

To check which capabilities are set on the Nekobox binary:

```bash
getcap /path/to/nekobox
```

- If nothing is returned, no capabilities are set.

## 3. Removing Capabilities

To remove all capabilities from the Nekobox binary:

```bash
sudo setcap -r /path/to/nekobox
```

## 4. References

- [man setcap](https://man7.org/linux/man-pages/man8/setcap.8.html)
- [man capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)

---
**Note:** Setting capabilities requires root privileges. Use with caution.
