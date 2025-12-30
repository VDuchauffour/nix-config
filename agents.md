# Agent Instructions

This document provides context for AI agents working with this NixOS/nix-darwin configuration repository.

## Project Overview

A Nix flake-based configuration managing multiple machines:

- **NixOS hosts**: deckard, joi, sebastian, wallace
- **Darwin hosts**: tyrell
- **User**: k

## Key Commands (from Makefile)

| Command         | Description                           |
| --------------- | ------------------------------------- |
| `make build`    | Build config, show diff with `nvd`    |
| `make switch`   | Apply configuration (default)         |
| `make check`    | Validate flake with `nix flake check` |
| `make test`     | Dry-build after check                 |
| `make update`   | Update flake.lock and rebuild         |
| `make rollback` | Rollback to previous generation       |
| `make boot`     | Apply config for next boot only       |
| `make repl`     | Open nixos-repl                       |

Auto-detects platform (Linux → `nixos-rebuild`, Darwin → `darwin-rebuild`).

## Directory Structure

```
.
├── flake.nix           # Entry point
├── flake.lock          # Pinned dependencies
├── hosts/              # Machine-specific configs
│   ├── darwin/         # macOS machines
│   └── nixos/          # NixOS machines
├── modules/            # Reusable modules
│   ├── common/         # Shared across all systems
│   ├── system/         # System-level (services, hardware)
│   └── user/           # User-level (home-manager)
├── home/k/             # User home config
├── packages/           # Package sets by platform
└── assets/             # Static files (wallpapers, etc.)
```

## Conventions

### Module Pattern

Modules use `default.nix` with options pattern:

```nix
{ config, lib, pkgs, ... }:
{
  # configuration here
}
```

### Platform-Specific Files

- `darwin.nix` - macOS only
- `nixos.nix` - NixOS only
- `default.nix` - cross-platform or primary config

### Adding New Software

1. **System service**: Add to `modules/system/<name>/default.nix`
2. **User application**: Add to `modules/user/<name>/default.nix`
3. **Package only**: Add to `packages/*.nix`

## Validation

Before committing changes:

```shell
make check   # Validate flake syntax and evaluation
make build   # Build without applying (shows diff)
```

## Common Pitfalls

- Don't edit `flake.lock` manually — use `make update`
- Home-manager modules go in `modules/user/`, not `modules/system/`
- Test on target platform before pushing (Darwin configs won't eval on NixOS)
- Secrets are managed with agenix (`modules/system/agenix/`)

## Hosts Reference

| Host      | Platform | Purpose               |
| --------- | -------- | --------------------- |
| joi       | NixOS    | Server/homelab        |
| deckard   | NixOS    | Primary workstation   |
| wallace   | NixOS    | Secondary workstation |
| sebastian | NixOS    | Raspberry Pi          |
| tyrell    | Darwin   | macOS machine         |
