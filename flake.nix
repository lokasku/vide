{
  description = "Nix-powered modal IDE composed of individual tools.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, zjstatus, ... }: let

    systems =  [ "x86_64-linux" "aarch64-linux" "aarch6-darwin" ];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    zjstatusForAllSystems = system: zjstatus.packages.${system}.default;
    in
      { 
        packages = forAllSystems (pkgs: {
          default = pkgs.callPackage ./vide.nix {
            inherit pkgs;
            zjstatus = zjstatusForAllSystems pkgs.system;
          };
        });

        apps = forAllSystems (pkgs: {
          default = {
            type = "app";
            program = "${pkgs.callPackage ./vide.nix {
              inherit pkgs;
              zjstatus = zjstatusForAllSystems pkgs.system;
            }}/bin/vide";
          };
        });
        
        devShells = forAllSystems (pkgs: {
          default = pkgs.mkShell {
            packages = [ pkgs.nixd ];
          };
        });
      };
}
