# Configuration files for my Nix-based devices

## Darwin

### Installation

```shell
# install XCode CLI tools
xcode-select --install

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install nix
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
# say no when asking for determinate OS

exec $SHELL

git clone https://github.com/VDuchauffour/nix-config.git ~/.nix-config
cd ~/.nix-config/darwin
sudo nix run nix-darwin -- switch --flake darwin/#k-MacBook-Pro

exec $SHELL
```
