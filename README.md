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

<details>
<summary>Homelab</summary>

Create a root password using the TTY

```shell
sudo su
passwd
```

Get the IP adress of the target machine

```shell
ip a
```

Ensure that the SSH server is running

```shell
sudo systemctl start sshd
```

From your host, copy your SSH keys to the server

```shell
export NIXOS_HOST=192.168.1.xxx

scp ~/.ssh/id_ed25519 root@$NIXOS_HOST:/root/
```

SSH into the target machine and adds keys to the SSH agent

You may need to copy keys to `/mnt/root/.ssh`

```shell
ssh root@$NIXOS_HOST

mkdir -p /root/.ssh
mv /root/id_ed25519 /root/.ssh/id_ed25519
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_ed25519

eval "$(ssh-agent -s)"
ssh-add /root/.ssh/id_ed25519
```

Install the system

```shell
nixos-install --flake "git+ssh://git@github.com/VDuchauffour/nix-config.git#sebastian"
```

Add user password

```shell
nixos-enter --root /mnt -c 'passwd alice'
```

For security, remove the keys when done

```shell
shred -u /root/.ssh/id_ed25519
```

Unmount the filesystems

```shell
umount -Rl "/mnt"
zpool export -a
```

Reboot

```shell
reboot
```

</details>

### Set up the configuration

```python
git clone https://github.com/VDuchauffour/nix-config.git ~/.nix-config
cd ~/.nix-config

sudo -E nix run nix-darwin -- switch --flake ~/.nix-config#tyrell
# or
sudo -E nixos-rebuild switch --flake ~/.nix-config#deckard
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

## Acknowledgments

- The tree structure and module definitions are inspired by [notthebee's nix-config](https://github.com/notthebee/nix-config/)
