{ stdenv
, pkgs
, lib
, writeShellScript
, callPackage

, zjstatus
}:

let
  kakLspConfig = ./kak-lsp/kak-lsp.toml;
  kakouneConfig = callPackage ./kakoune.nix { inherit kakLspConfig; };
  brootConfig = callPackage ./broot.nix {};
  kks = callPackage ./kks.nix {};
  helixConfig = callPackage ./helix.nix {};
  zellijConfig = callPackage ./zellij.nix { inherit zjstatus helixConfig; };
  lazyGitConfig = ./lazygit/config.yml;
in
  stdenv.mkDerivation rec {
    name = "vide";

    src = writeShellScript "vide" ''
      export KAKOUNE_CONFIG_DIR=${kakouneConfig}
      export BROOT_CONFIG_DIR=${brootConfig}
      export ZELLIJ_CONFIG_DIR=${zellijConfig}
      export LG_CONFIG_FILE=${lazyGitConfig}
      echo ${kakLspConfig}
      echo ${lib.getExe pkgs.kak-lsp} --help
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
