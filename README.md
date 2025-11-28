# Configuration files for my Nix-based devices

This repository contains the configuration files for my Nix-based devices, both Darwin and NixOS.

You can customize the configuration to your liking.

## How to use the configuration

```python
git clone https://github.com/VDuchauffour/nix-config.git ~/.nix-config
cd ~/.nix-config

make switch
```

## Installation

<details>
<summary>Remote installation</summary>

Create a root password using the TTY

```shell
sudo su
passwd
```

[Set up the network](https://nixos.org/manual/nixos/stable/#sec-installation-manual-networking) in the installer if needed.

Get the IP adress of the target machine

```shell
ip a
```

Ensure that the SSH server is running

```shell
sudo systemctl start sshd
```

From your host, copy the public SSH key to the server

```shell
export NIXOS_HOST=192.168.1.xxx

# you may need to run eval "$(ssh-agent -s)"
# and also generate a new pair of keys with ssh-keygen -t ed25519 -f ~/.ssh/new-hostname

ssh-add ~/.ssh/new-hostname
ssh-copy-id -i ~/.ssh/new-hostname root@$NIXOS_HOST
```

SSH into the host with agent forwarding enabled (for the secrets repo access)

```shell
ssh -A root@$NIXOS_HOST
```

Perform [partitioning and formatting](https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning) if needed. Then run `nixos-generate-config --root /mnt` to get device ID.
If you want to use disko, run

```shell
nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko \
  -- -m destroy,format,mount path/to/disko.nix
```

Install git

```bash
nix-env -f '<nixpkgs>' -iA git
```

Clone this repository

```bash
mkdir -p /mnt/etc/nixos
git clone https://github.com/VDuchauffour/nix-config.git /mnt/etc/nixos
```

Put the private key into place (required for secret management) and any other required keys (like GitHub)

```shell
mkdir -p /mnt/home/k/.ssh
exit

scp ~/.ssh/new-hostname root@$NIXOS_HOST:/mnt/home/k/.ssh
ssh root@$NIXOS_HOST
chmod 700 /mnt/home/k/.ssh
chmod 600 /mnt/home/k/.ssh/*
```

Install the system

```shell
nixos-install \
--root "/mnt" \
--flake "git+file:///mnt/etc/nixos#hostname"
```

Apply final tweaks on the new NixOS

```shell
nixos-enter --root
passwd k
git clone git@github.com:VDuchauffour/nix-config.git ~/.nix-config
# checks also owner and groups for ~/.ssh
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

## Nix-darwin installation

Before using a nix-darwin configuration, you need to set up the prerequisites.

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

Use the following command to update the lock file:

```shell
make update
```

Use the following command to list all installed packages on your machine:

```shell
nix-env -qaP
```

To generate an `hostId`, see this [link](https://mynixos.com/nixpkgs/option/networking.hostId).

## Acknowledgments

- The tree structure and module definitions are inspired by [notthebee's nix-config](https://github.com/notthebee/nix-config/)
- The Makefile comes from [minego's nixos-config](https://github.com/minego/nixos-config)
