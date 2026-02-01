# Configuration files for my Nix-based devices

This repository contains the configuration files for my Nix-based devices, both Darwin and NixOS. You can customize the configuration to your liking.

## Usage

```python
git clone https://github.com/VDuchauffour/nix-config.git ~/.nix-config
cd ~/.nix-config

make switch
```

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
export NEW_HOSTNAME=XYZ

# you may need to run eval "$(ssh-agent -s)"
# and also generate a new pair of keys with ssh-keygen -t ed25519 -f ~/.ssh/$NEW_HOSTNAME

ssh-add ~/.ssh/$NEW_HOSTNAME
ssh-copy-id -i ~/.ssh/$NEW_HOSTNAME root@$NIXOS_HOST
```

SSH into the host with agent forwarding enabled (for the secrets repo access)

```shell
ssh -A root@$NIXOS_HOST
```

Perform [partitioning and formatting](https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning) if needed. Then run `nixos-generate-config --root /mnt` to get device ID.
If you want to use disko, run

```shell
curl https://raw.githubusercontent.com/vduchauffour/nix-config/main/hosts/nixos/$NEW_HOSTNAME/disko.nix \
  -o /tmp/disko.nix

nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko \
  -- -m destroy,format,mount /tmp/disko.nix
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

scp ~/.ssh/$NEW_HOSTNAME root@$NIXOS_HOST:/mnt/home/k/.ssh
ssh root@$NIXOS_HOST
chmod 700 /mnt/home/k/.ssh
chmod 600 /mnt/home/k/.ssh/*
```

Install the system

```shell
nixos-install \
--root "/mnt" \
--flake "git+file:///mnt/etc/nixos#$NEW_HOSTNAME"
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

## Special cases

<details>
<summary>Raspberry Pi</summary>

To handle the lack of RAM, add a swap during installation

```shell
# create a 3G swap file (you can do 2048 if you prefer 2G)
dd if=/dev/zero of=/swapfile bs=1M count=3072 status=progress

chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

free -h
```

And use the following option to reduce memory pressure during `nixos-install` command

```shell
nixos-install \
  --root "/mnt" \
  --flake "git+file:///mnt/etc/nixos#$NEW_HOSTNAME" \
  --option max-jobs 1 \
  --option cores 1

# if still OOM, add
  --option sandbox false
```

You can also build the config on the host machine, copying it and installing it in the remote machine

```shell
nix build .#nixosConfigurations.$NEW_HOSTNAME.config.system.build.toplevel --print-out-paths
nix copy path/to/build --to ssh://root@$NIXOS_HOST

# on the remote machine
nixos-install --root /mnt --system
```

</details>

</details>

<details>
<summary>Nix-darwin</summary>

Before using a nix-darwin configuration, you need to set up the prerequisites.

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

If the boot isn't updated on the next boot, use the following command:

```shell
make boot
```

Use the following command to list all installed packages on your machine:

```shell
nix-env -qaP
```

To get default hardware-configuration.nix without the filesystem mapping:

```shell
nixos-generate-config --root /mnt --no-filesystems
```

To generate an `hostId`, see this [link](https://mynixos.com/nixpkgs/option/networking.hostId).

To use `fprint`, run `sudo fprintd-enroll <username> --finger <finger>`.

To enable snapshot for ZFS datasets, run `zfs set com.sun:auto-snapshot=true <dataset-name>`.

## Acknowledgments

- The tree structure and module definitions are inspired by [notthebee's nix-config](https://github.com/notthebee/nix-config/)
- The Makefile comes from [minego's nixos-config](https://github.com/minego/nixos-config)
