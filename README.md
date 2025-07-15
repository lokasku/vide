# Vide

Nix-powered modal IDE composed of individual tools, namely :

- [Zellij](https://zellij.dev)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Kakoune](https://kakoune.org/)
- [Broot](dystroy.org/broot)

## Motivation

Leveraging Nix flakes, `nix run github:lokasku/vide` enables a fully reproducible and ephemeral IDE environment on any system with Nix installed, utilizing the _flakes_ and _nix-command_ experimental features. This setup ensures the IDE leaves no trace after garbage collection, with configurations entirely encapsulated to deliver a consistent interface, independent of any existing XDG configurations.

This solution is ideal for frequent system transitions, eliminating the need for reinstallation or reconfiguration of the IDE. The modal design reduces dependencies to just a terminal application, available on nearly all platforms.

This IDE addresses the challenges of frequent IDE reconfiguration, offering a rapid, uniform development environment that bypasses time-intensive setup, including managing dotfiles and symlinks.

## Installation

While the primary purpose is to be able to run the IDE by URL as shown above, it's also possible to install it on your system, either declaratively or imperatively.

### NixOS/nix-darwin

```nix
{
  inputs = {
    ...
    vide.url = "github:lokasku/vide";
  };

  outputs = inputs @ { self, ... }: {
    nixosConfigurations.myconfig = nixos.lib.nixosSystem rec {
      ...
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
    };
  };
}
```

```nix
{ pkgs
, inputs
, system
, ...
}:
  {
    environment.systemPackages = [
      inputs.vide.packages.${system}.vide
    ];
  }
```

### Home Manager

```nix
{
  inputs = {
    ...
    vide.url = "github:lokasku/vide";
  };

  outputs = { nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.lokasku = home-manager.lib.homeManagerConfiguration {
        ...
        extraSpecialArgs = {
          inherit inputs system;
        };
      };
    };
}
```

```nix
{ pkgs
, inputs
, system
, ...
}:
  {
    home.packages = [
      inputs.vide.packages.${system}.vide
    ];
  }
```
