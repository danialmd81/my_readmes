# Understanding and Customizing the Boot Splash Screen on Linux

---

## 1. **What is a Boot Splash or Splash Screen?**

A **boot splash** (or **splash screen**) is a picture or animation that appears on your screen while your operating system is loading, right after you pick it from the boot menu.

- **Boot**: The process of starting up your computer and loading the operating system.
- **Splash**: A quick, usually simple, image or animation shown to make the startup look nicer and hide technical messages.
- **Operating system**: The main software that lets you use your computer (like Linux, Windows, or macOS).
- **Loading**: The computer is getting everything ready for you to use.

---

## 2. **Who Controls the Splash Screen?**

The splash screen is usually controlled by a program called **Plymouth** or a similar tool, not by systemd-boot itself.

- **Plymouth**: A program that shows a graphical splash screen during the boot process.
- **Graphical**: Uses images or animations, not just text.
- **Boot process**: The series of steps your computer takes to start up.

---

## 3. **How Can You Change the Splash Screen Logo?**

To change the splash screen logo, you need to change the **theme** or **image** used by Plymouth (or whatever splash program your system uses).

- **Theme**: A set of images, colors, and styles that decide how something looks.
- **Image**: A picture file, like a PNG or JPG.

### **Steps for openSUSE (and Most Linux Systems):**

1. **Find out which splash program you use.**  
   Most modern systems use Plymouth.

2. **List available Plymouth themes:**  
   Open a terminal and run:

   ```bash
   sudo plymouth-set-default-theme --list
   ```

   - **Terminal**: A program where you type commands.
   - **sudo**: Lets you run commands as an administrator.
   - **plymouth-set-default-theme**: A command to manage Plymouth themes.
   - **--list**: Shows all available themes.

3. **Set a new theme:**  
   For example, to set the "bgrt" theme:

   ```bash
   sudo plymouth-set-default-theme bgrt
   sudo dracut --force
   ```

   - **dracut**: A tool that rebuilds the initial RAM disk (initrd), which is needed for the splash to work.
   - **--force**: Tells dracut to rebuild even if it thinks it’s not needed.

4. **Customize the theme:**  
   If you want your own logo, you can edit or create a custom Plymouth theme. This usually means replacing an image file in the theme’s folder (often in `/usr/share/plymouth/themes/`).

5. **Reboot your computer** to see the new splash screen.

---

## 4. **Summary**

- The logo you see while your system is booting (after the menu) is controlled by a splash program like Plymouth, not systemd-boot.
- To change it, you need to change the Plymouth theme or its images.
- This involves using terminal commands and sometimes editing files.

---

## 5. **Previewing a Plymouth Theme**

### 1. **Open a Terminal**

A **terminal** is a program where you can type commands for your computer to run.

### 2. **Start the Plymouth Daemon in the Background**

Type:

```bash
sudo plymouthd
```

- **plymouthd**: The Plymouth daemon (a background program that manages the splash screen).

### 3. **Show the Plymouth Splash Screen Preview**

Type:

```bash
sudo plymouth --show-splash
```

- **plymouth**: The command-line tool to control Plymouth.
- **--show-splash**: Tells Plymouth to display the splash screen.

### 4. **Stop the Preview**

```bash
sudo plymouth --quit
```

### 5. **Change the Theme for Previewing**

To preview a different theme (without setting it as default), use:

```bash
sudo plymouth-set-default-theme THEME_NAME
sudo plymouthd
sudo plymouth --show-splash
```

- **THEME_NAME**: The name of the theme you want to preview (like `spinner` or `bgrt`).

### 6. **Summary**

- Use `sudo plymouthd` and `sudo plymouth --show-splash` to preview a theme.
- Change the theme with `sudo plymouth-set-default-theme THEME_NAME` before previewing.
- This lets you see what the splash screen will look like before you reboot.

---

## 6. **Recursive Explanation of Keywords**

### - **Program**: A set of instructions that tells your computer what to do. Examples: web browsers, games, or music players

### - **Administrator**: A user with special permissions to make changes to the system

### - **Command**: An instruction you type into the terminal to tell the computer to do something

### - **Folder**: A place to store files and other folders, like a digital version of a real-life folder

### - **File**: A collection of information stored on your computer, like a photo, document, or song

### - **Background Program (Daemon)**: A program that runs without you seeing it, doing important work for your computer

### - **Command-line Tool**: A program you use by typing commands, instead of clicking with a mouse

### - **Reboot**: Restarting your computer so it turns off and then on again

---

**You now know what a boot splash is, who controls it, how to change it, and how to preview your changes—all with beginner-friendly explanations
