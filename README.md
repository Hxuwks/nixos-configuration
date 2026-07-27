# Modular NixOS & Home-Manager Configuration

![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Flakes](https://img.shields.io/badge/Nix_Flakes-Enabled-blueviolet?style=for-the-badge&logo=nixos&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Modular-success?style=for-the-badge)

Declarative, zero-drift system configuration for daily driving, network labs, and security operations. Built with **Nix Flakes**, **Home-Manager**, and **GNOME**.

---

##  Repository Structure

```text
.
├── flake.nix              # Main entry point for system configurations & inputs
├── flake.lock             # Lockfile for reproducible dependencies
├── hosts/                 # Machine-specific configurations
│   └── thinkpad/          # ThinkPad E14 Gen 5 (Ryzen 7 7730U)
│       ├── default.nix    # Host entrypoint
│       └── hardware.nix   # Hardware scan & kernel modules
├── modules/               # Reusable system-level modules (NixOS)
│   ├── core/              # Essential OS settings (boot, locale, nix settings)
│   ├── services/          # System daemons (AmneziaWG, Docker/Podman, SSH)
│   └── desktop/           # Display manager & GNOME environment
└── home/                  # User-level configurations (Home-Manager)
    ├── default.nix        # Home-Manager entrypoint
    ├── packages.nix       # User space CLI & GUI binaries
    └── modules/           # Dotfiles & user app configs (Neovim, VS Code, Git)
```

## System Architecture

The configuration follows a strict separation of concerns:

- `hosts/` — Hardware-bound configurations. Define unique machine specs, disk layouts, and hostnames here.
- `modules/` — System-level services and configurations that require root privileges (bootloader, firewall, networking, desktop managers).
-  `home/` — Declarative user environments using Home-Manager. All CLI tools, dotfiles, desktop settings, and editor configurations live here.

## Features & Stack

- **OS**: NixOS (Flake-enabled)
-  **Desktop Environment**: GNOME (minimal, declarative theme)
- **Editors**:
    - **Neovim**: Fast CLI-first editor for rapid system tweaks & SSH sessions.
    - **VS Code**: Full-fledged IDE for complex developments.
- **Networking & Security**: Custom AmneziaWG VPN integration, Containerlab environment support.

## How to Use & Extend
### Rebuilding the System
Apply changes locally from the configuration root:

```Bash
sudo nixos-rebuild switch --flake .#thinkpad
//or
rebuild
```

### Adding a New User Package
Add the package name directly to home/packages.nix:
```Nix

home.packages = with pkgs; [
  wireshark
  containerlab
];
```

### Adding a New System Module

1. Create a new `.nix` file under `modules/services/` or `modules/core/`.

2. Import it in `hosts/thinkpad/default.nix`:

```Nix

imports = [
  ../../modules/services/your-new-service.nix
];
```

### Housekeeping (Garbage Collection)
To purge old generations and keep `systemd-boot` clean:
```Bash
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
sudo nix-collect-garbage -d
sudo nixos-rebuild boot
```
