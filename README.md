# Configuration files for my Nix-based devices

This repository contains the configuration files for my Nix-based devices, both Darwin and NixOS.

You can customize the configuration to your liking.

## Nix-darwin

Before using the nix-darwin configuration, you need to install the prerequisites.

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

### Set up the configuration

```python
git clone https://github.com/VDuchauffour/nix-config.git ~/.nix-config
cd ~/.nix-config
sudo nix run nix-darwin -- switch --flake ./machines/darwin/tyrell/#k-MacBook-Pro
```

### Post-install configuration

<details>
<summary>Logitech G Hub</summary>

Go to `System Settings > Privacy & Security` and apply the following changes:

- allow `Logitech G Hub` to control Accessibility, Input Monitoring, and Screen & System Audio Recording.
- allow `Logitech G Hub Agent` to control Accessibility.

You may need to add manually the Applications to the list of allowed applications.

</details>
