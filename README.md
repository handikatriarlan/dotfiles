<p align="center">
  <img src="./screenshots/desktop.png" width="100%" />
</p>

<h1 align="center">Fedora KDE Dotfiles</h1>

<p align="center">
  Personal Fedora KDE setup powered by Kitty, Zsh, Starship, Plasma, and others.
</p>

## Preview

A collection of configuration files, themes, fonts, and package lists used to customize my Fedora KDE environment.

## Environment

* OS: Fedora Linux
* Desktop Environment: KDE Plasma
* Terminal: Kitty
* Shell: Zsh
* Prompt: Starship
* Bootloader: GRUB
* Fonts: JetBrains Mono and other system fonts
* Theme: Custom KDE and GTK themes

## Repository Structure

```text
.
├── config/         # Application configuration files
├── fonts/          # Font configuration and installation resources
├── grub/           # GRUB customization
├── home/           # Files placed in $HOME
├── kde/            # KDE Plasma settings
├── packages/       # Installed package lists
├── screenshots/    # Desktop screenshots
└── themes/         # Themes and appearance settings
```

## Installation

Clone the repository:

```bash
git clone https://github.com/handikatriarlan/dotfiles.git
cd dotfiles
```

Copy the desired configuration files to your system:

```bash
cp -r config/* ~/.config/
```

Or manually install only the components you need.

## Packages

Installed packages are stored in:

```text
packages/
```

To install packages from the generated list:

```bash
sudo dnf install $(cat packages/dnf.txt)
```

## Fonts

Font archives are intentionally not included in this repository due to GitHub file size limitations.

Install fonts manually and place any required font configuration files inside:

```text
fonts/
```

## Screenshots

Desktop screenshots can be found in:

```text
screenshots/
```

## Notes

These dotfiles are tailored to my personal workflow and setup. Some configurations may require additional packages, themes, fonts, or KDE extensions to work correctly.

Feel free to use them as inspiration for your own setup.
