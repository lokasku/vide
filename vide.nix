{ stdenv
, pkgs
, lib
, writeShellScript
, zellij
, callPackage

, zjstatus
}:

let
  zellijConfig = callPackage ./zellij { inherit zjstatus; };
in
  stdenv.mkDerivation rec {
    name = "vide";

    buildInputs = [ zellij zellijConfig ];

    src = writeShellScript "vide" ''
      export ZELLIJ_CONFIG_FILE=${zellijConfig}/share/zellij/config.kdl
      echo ${zellijConfig}
      echo ${zjstatus}
      echo ${zellij}
      ${zellij}/bin/zellij
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/vide
      chmod +x $out/bin/vide
    '';

    dontUnpack = true;

    meta = {
      description = "A Nix-powered modal IDE composed of individual tools.";
      homepage = "https://github.com/lokasku/vide";
      mainProgram = "vide";
    };
  }
