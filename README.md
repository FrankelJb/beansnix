<h3 align="center">
 <img src="https://nixos.org/logo/nixos-logo-only-hires.png" height="20" /> NixOS Config for <a href="https://github.com/FrankelJb">FrankelJb</a>
 <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
  <a href="https://nixos.wiki/wiki/Flakes" target="_blank">
 <img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge">
</a>
<a href="https://github.com/snowfallorg/lib" target="_blank">
 <img alt="Built With Snowfall" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&labelColor=5e81ac&message=Snowfall&color=d8dee9&style=for-the-badge">
</a>
</p>

Welcome to BeansNix, a personal Nix configuration repository. This repository contains my NixOS and Nixpkgs configurations, along with various tools and customizations to enhance the Nix experience.

## Features

Here's an overview of what my Nix configuration offers:

- **External Dependency Integrations**:
  - Easily integrate Astronvim and my personal Astronvim [config](https://github.com/khaneliman/khanelivim).
  - Access the Nix User Repository (NUR) for additional packages and
    enhancements.
  - Incorporate Nixpkgs-Wayland to provide an up-to-date Wayland package
    repository.

- **macOS Support**: Seamlessly configure and manage Nix on macOS using the
  power of Nix-darwin, also leveraging homebrew for GUI applications.

- **Home Manager**: Manage your dotfiles, home environment, and user-specific
  configurations with Home Manager.

- **DevShell Support**: The flake provides a development shell (`devShell`) to
  support maintaining this flake. You can use the devShell for convenient
  development and maintenance of your Nix environment.

- **CI with Cachix**: The configuration includes continuous integration (CI)
  that pushes built artifacts to Cachix. This ensures efficient builds and
  reduces the need to build dependencies on your local machine.

- **Utilize sops-nix**: Secret management with sops-nix for secure and encrypted
  handling of sensitive information.

## Customization

My Nix configuration, based on the SnowfallOrg lib structure, provides a
flexible and organized approach to managing your Nix environment. Here's how it
works:

- **Custom Library**: An optional custom library in the `lib/` directory
  contains a Nix function called with `inputs`, `snowfall-inputs`, and `lib`.
  The function should return an attribute set to merge with `lib`.

- **Modular Directory Structure**: You can create any (nestable) directory
  structure within `lib/`, `packages/`, `modules/`, `overlays/`, `systems/`, and
  `homes/`. Each directory should contain a Nix function that returns an
  attribute set to merge with the corresponding section.

- **Package Overlays**: The `packages/` directory includes an optional set of
  packages to export. Each package is instantiated with `callPackage`, and the
  files should contain functions that take an attribute set of packages and the
  required `lib` to return a derivation.

- **Modules for Configuration**: In the `modules/` directory, you can define
  NixOS modules for various platforms, such as `nixos`, `darwin`, and `home`.
  This modular approach simplifies system configuration management.

- **Custom Overlays**: The `overlays/` directory is for optional custom
  overlays. Each overlay file should contain a function that takes three
  arguments: an attribute set of your flake's inputs and a `channels` attribute
  containing all available channels, the final set of `pkgs`, and the previous
  set of `pkgs`. This allows you to customize package sets effectively.

- **System Configurations**: The `systems/` directory organizes system
  configurations based on architecture and format. You can create configurations
  for different architectures and formats, such as `x86_64-linux`,
  `aarch64-darwin`, and more.

- **Home Configurations**: Similar to system configurations, the `homes/`
  directory organizes home configurations based on architecture and format. This
  is especially useful if you want to manage home environments with Nix.

This structured approach to Nix configuration makes it easier to manage and customize your Nix environment while maintaining flexibility and modularity.
    
## Credits

Thanks to the monumental effort from pioneers like [Khaneliman](https://github.com/khaneliman), [fufexan](https://github.com/fufexan) and the other hyprland and nixos community members.
