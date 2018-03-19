![icn](images/twupic.png)

# About

Simple bash scripts to check new snapshots and update openSUSE Tumbleweed.

Currently, the only method to update openSUSE Tumbleweed is by using terminal and manually do "zypper ref" then "zypper dup". PackageKit' appcenters and YaST can't handle Tumbleweed snapshots. These tools provide an automated way to do it, it's more convenient and more beginner-friendly. And you'll get a notification if updates are available.

Two versions: "CLI" or "GUI" _(text-based or graphical)_.

Screenshot of "CLI" main menu: [click here](https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/images/twupscreen.png)

# Installation

ENGLISH:
```
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/install-en.sh
chmod +x install-en.sh
sudo ./install-en.sh
rm install-en.sh
```

FRENCH:
```
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/install-fr.sh
chmod +x install-fr.sh
sudo ./install-fr.sh
rm install-fr.sh
```

You'll see `TWupdater (CLI)` _(recommended)_ and `TWupdater (GUI)` in your applications now.

# Usage

__Recommended version is "CLI"__, because you can control what "zypper dup" is doing _("GUI" enables autoconfirm which could be risky sometimes)_. If you are a beginner, don't be afraid, "CLI" version is very easy to understand and use.

These tools should work on any desktop, however I've only tested with GNOME and KDE.

# Tweaks

- If you want to have different icons for "CLI" and "GUI":
  - `sudo sed -i 's/twupic/twupic-cli/g' /usr/share/applications/TWupdater-CLI.desktop`
  - `sudo sed -i 's/twupic/twupic-gui/g' /usr/share/applications/TWupdater-GUI.desktop`
  
- If you want to change notification frequency _(default: 45 minutes)_:
  - `sudo sed -i 's/45m/CUSTOM-VALUE/g' /usr/bin/snapshek.sh`
  - `CUSTOM-VALUE` can be Xm for minutes, Xh for hours, etc...

---

![fig](images/twupba.png)
