{
  pkgs,
  stdenv,
}: let
  brootConfig = pkgs.runCommand "broot-config" {} ''
    mkdir -p $out/config

    cat > $out/conf.hjson <<EOF
    # hello
    EOF
  '';
in
  stdenv.mkDerivation {
    name = "broot-config";
    buildCommand = ''
      mkdir -p $out
      cp -r ${brootConfig}/* $out
    '';
  }
