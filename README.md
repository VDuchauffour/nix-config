# Configuration files for my Nix-based devices

This repository contains the configuration files for my Nix-based devices, both Darwin and NixOS.

You can customize the configuration to your liking.

## Prerequisites

Before using a NixOS or nix-darwin configuration, you need to install the prerequisites.

<details>
<summary>NixOS prerequisites</summary>

```shell

```

</details>

<details>
<summary>nix-darwin prerequisites</summary>

```shell
# install XCode CLI tools
xcode-select --install

# install Rosetta
sudo softwareupdate --install-rosetta

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install nix
# say no when asking for determinate OS
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
exec $SHELL
```

</details>

## Installation

### Set up the configuration

```python
git clone https://github.com/VDuchauffour/nix-config.git ~/.nix-config
cd ~/.nix-config

sudo nix run nix-darwin -- switch --flake .#tyrell
# or
sudo nixos-rebuild switch --flake .#deckard
```

### Post-install configuration

<details>
<summary>Logitech G Hub (nix-darwin only)</summary>

Go to `System Settings > Privacy & Security` and apply the following changes:

- allow `Logitech G Hub` to control Accessibility, Input Monitoring, and Screen & System Audio Recording.
- allow `Logitech G Hub Agent` to control Accessibility.

You may need to add manually the Applications to the list of allowed applications.

</details>

## Misc

Use the following command to check the value of an option on your current system:

```shell
nixos-option --flake .#hostName options.path.value
```

Use the following command to update only the Nix-related inputs in the lock file:

```shell
nix flake update nixpkgs nixpkgs-unstable nixpkgs-nixos nix-darwin home-manager home-manager-unstable
```

Use the following command to list all installed packages on your machine:

```shell
nix-env -qaP
```
