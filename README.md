![fig](images/twupba.png)

# About

Simple bash scripts to check new snapshots and update openSUSE Tumbleweed.

Currently, the only method to update openSUSE Tumbleweed is by using terminal and manually do "zypper ref" then "zypper dup". PackageKit' appcenters and YaST can't handle Tumbleweed snapshots. These tools provide an automated way to do it, it's more convenient and more beginner-friendly. And you'll get a notification if updates are available.

# Usage

Two options: "CLI" or "GUI" _(text-based or graphical)_.

__Recommended version is "CLI"__, because you can control what "zypper dup" is doing _("GUI" enables autoconfirm which could be risky sometimes)_. If you are a beginner, don't be afraid, "CLI" version is very easy to understand and use.

# Installation

WIP

# Tweaks

- If you want to have different icons for "CLI" and "GUI":
  - `sudo sed -i 's/twupic/twupic-cli/g' /usr/share/applications/TWupdater-CLI.desktop`
  - `sudo sed -i 's/twupic/twupic-gui/g' /usr/share/applications/TWupdater-GUI.desktop`
