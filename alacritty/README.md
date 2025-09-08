# Alacritty Configuration

This project provides a beautiful and customizable configuration setup for Alacritty, a fast and lightweight terminal emulator.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Customization](#customization)
- [Tips](#tips)

## Installation

To install Alacritty, follow the instructions for your operating system:

### macOS

You can install Alacritty using Homebrew:

```bash
brew install --cask alacritty
```

### Linux

For most Linux distributions, you can install Alacritty using your package manager. For example, on Ubuntu:

```bash
sudo add-apt-repository ppa:aslatter/ppa
sudo apt update
sudo apt install alacritty
```

### Windows

Download the latest release from the [Alacritty GitHub Releases page](https://github.com/alacritty/alacritty/releases) and follow the installation instructions provided there.

## Usage

Once Alacritty is installed, you can launch it from your applications menu or by running `alacritty` in your terminal.

To use the provided configuration, copy the `alacritty.toml` file from the `config` directory to your Alacritty configuration directory. The default configuration directory is:

- **Linux/macOS**: `~/.config/alacritty/alacritty.toml`
- **Windows**: `%APPDATA%\alacritty\alacritty.toml`

## Customization

The `alacritty.yml` file contains various settings that you can customize to enhance your terminal experience. Some of the key options include:

- **Font Size**: Adjust the font size to your preference.
- **Colors**: Change the color scheme to match your style.
- **Key Bindings**: Modify key bindings to suit your workflow.

Feel free to explore the configuration file and make changes as needed.

## Tips

- Experiment with different color schemes to find one that you like.
- Use the `alacritty.yml` file as a reference to learn more about the available options.
- Check the [Alacritty documentation](https://github.com/alacritty/alacritty/blob/master/README.md) for more advanced configuration options and features.

Enjoy your personalized Alacritty terminal experience!
