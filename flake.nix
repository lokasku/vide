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
    systems = ["x86_64-linux" "aarch64-linux" "aarch6-darwin"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    zjstatusForAllSystems = system: zjstatus.packages.${system}.default;
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: let
      vide = pkgs.callPackage ./vide.nix {
        inherit pkgs kks-source;
        zjstatus = zjstatus.packages.${pkgs.system}.default;
      };
    in {
      default = vide;
      vide = vide;
    });

    apps = forAllSystems (pkgs: {
      default = {
        type = "app";
        program = pkgs.lib.getExe (pkgs.callPackage ./vide.nix {
          inherit pkgs kks-source;
          zjstatus = zjstatus.packages.${pkgs.system}.default;
        });
      };
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [nil blink];
      };
    });
  };
}
