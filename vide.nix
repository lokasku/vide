{ stdenv
, pkgs
, lib
, writeShellScript
, callPackage

, zjstatus
}:

let
  zellijConfig = callPackage ./zellij.nix { inherit zjstatus; };
  kakouneConfig = callPackage ./kakoune.nix {};
  brootConfig = callPackage ./broot.nix {};
  kks = callPackage ./kks.nix {};
in
  stdenv.mkDerivation rec {
    name = "vide";

    buildInputs = [ pkgs.zellij zellijConfig kakouneConfig kks ];

    src = writeShellScript "vide" ''
      export KAKOUNE_CONFIG_DIR=${kakouneConfig}
      export ZELLIJ_CONFIG_DIR=${zellijConfig}
      export BROOT_CONFIG_DIR=${brootConfig}
      echo ${brootConfig}
      echo ${pkgs.broot}
      echo ${kks}
      ${pkgs.zellij}/bin/zellij
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/vide
      chmod +x $out/bin/vide
    '';

    dontUnpack = true;

    meta = {
      description = "Nix-powered modal IDE composed of individual tools.";
      homepage = "https://github.com/lokasku/vide";
      mainProgram = "vide";
    };
  }
