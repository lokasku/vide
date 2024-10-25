{
  pkgs,
  lib,
  stdenv,
}: let
  config = ./config.toml;
in
  stdenv.mkDerivation {
    name = "helix-config";
    src = null;
    buildCommand = ''
      mkdir -p $out

      cat > $out/config.toml <<EOF
      ${config}
      EOF
    '';
  }
