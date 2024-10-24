{
  stdenv,
  pkgs,
  lib,
  writeShellScript,
  callPackage,
  zjstatus,
  kks-source,
}: let
  kakLsp = callPackage ./kaklsp.nix {};
  kakouneConfig = callPackage ./kakoune.nix {inherit kakLsp kks;};
  brootConfig = callPackage ./broot.nix {};
  kks = callPackage ./kks.nix {src = kks-source;};
  zellijConfig = callPackage ./zellij.nix {inherit zjstatus kakouneConfig;};
  lazyGitConfig = ./lazygit/config.yml;
in
  stdenv.mkDerivation rec {
    name = "vide";

    src = writeShellScript "vide" ''
      export ZELLIJ_CONFIG_DIR=${zellijConfig}
      export KAKOUNE_CONFIG_DIR=${kakouneConfig}
      export BROOT_CONFIG_DIR=${brootConfig}
      export LG_CONFIG_FILE=${lazyGitConfig}
      ${lib.getExe pkgs.zellij}
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
