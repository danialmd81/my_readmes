# Battery Charging limiter Linux (ASUS Laptops)

When the laptop is being constantly used with a charger plugged in it is better to limit the charging at 60% to 80% to improve the battery health.
Many laptop vendors like Asus provide software utility to set the battery max charge threshold but it works only in windows.

With Linux kernel 5.4 added the ability to set a battery charge threshold for many Asus laptops this script uses it to set the limit.

## Usage

Run the script limitd.sh with max battery threshold as an argument

For operating systems with systemd use other script limitd.sh that will create a systemd service to apply the limit on system reboot.

`eg: ./limitd.sh 60`

*limitd.sh set limit will persist on system reboot*

### Renable full capacity

Run the limitd.sh script with 100%

`./limitd.sh 100`

This will persist the change on reboot if systemd is available

Note: make the scripts executable before running by executing
`eg: chmod +x limitd.sh`

## More info

* [ASUS Battery Information Center](https://www.asus.com/support/FAQ/1038475/)
* [Arch Wiki](https://wiki.archlinux.org/index.php/Laptop/ASUS#Battery_charge_threshold)

-----
>Tested with :
>
> * Asus vivobook 15 with AMD Ryzen 3500U running Linux mint 20 Kernal 5.8.0-25-generic;
> * Asus Vivobook 15 PRO OLED Ryzen5900 M3500 using 5.3.1 artix-linux;
> * Asus TUF Gaming F15 using Debian 12;
> * Asus TUF Gaming F15 using Pop!_OS 22.04;
> * Asus TUF Gaming F15 using openSUSE Tumbleweed;
