# Vide
Nix-powered modal IDE composed of individual tools, namely :
- [Zellij](https://zellij.dev)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Helix](https://helix-editor.com/)
- [Kakoune](https://kakoune.org/)
## Motivation
Thanks to Nix flakes, one can directly invoke `nix run github:lokasku/vide` from any computer with Nix installed, using the flakes and nix-command experimental features. The IDE will run and leave no trace after garbage collection. The configuration is completely standalone, ensuring you get the exact same interface regardless of any potential XDG configurations.

This is particularly advantageous if you often have to switch computers, as it eliminates the need to reinstall and reconfigure your entire IDE setup. Since it is modal, the only additional requirement besides Nix is a terminal application, which is available on virtually all operating systems.

The motivation behind designing this IDE was my frequent need to use preconfigured tools due to the time-consuming process of setting up a new IDE (even creating symlinks from existing dotfiles). This project addresses that challenge, offering a quick and consistent development environment across different machines.
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
## Credits
This project was inspired by [Felko's Vide](https://github.com/felko/vide) project. The original idea of using Nix to combine various tools belongs to him. Thank you Felko for sharing this concept.
