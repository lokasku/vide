{
  description = "Nix-powered modal IDE composed of individual tools.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kks-source = {
      url = "github:kkga/kks";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    zjstatus,
    kks-source,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

    vide = pkgs: let
      kakLsp = pkgs.callPackage ./tools/kaklsp.nix {};
      kks = pkgs.callPackage ./tools/kks.nix {src = kks-source;};
      kakouneConfig = pkgs.callPackage ./configs/kakoune {
        inherit kakLsp kks;
        selectFile = pkgs.callPackage ./scripts/select-file.nix {inherit kks;};
      };
      brootConfig = pkgs.callPackage ./configs/broot {};
      zellijConfig = pkgs.callPackage ./configs/zellij {
        zjstatus = zjstatus.packages.${pkgs.system}.default;
      };
      lazyGitConfig = ./configs/lazygit/config.yml;
    in
      pkgs.callPackage ./default.nix {
        inherit kakLsp kks kakouneConfig brootConfig zellijConfig lazyGitConfig;
      };
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: {
      default = vide pkgs;
      vide = vide pkgs;
    });

    apps = forAllSystems (pkgs: {
      default = {
        type = "app";
        program = pkgs.lib.getExe (vide pkgs);
      };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [nil blink kakoune broot (pkgs.callPackage ./tools/kks.nix {src = kks-source;})];
      };
    });
  };
}
