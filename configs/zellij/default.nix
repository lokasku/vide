{
  pkgs,
  stdenv,
  zjstatus,
  kks, # temp
}: let
  config = pkgs.callPackage ./config {inherit zjstatus kks;};
in
  stdenv.mkDerivation {
    name = "zellij-config";
    src = null;
    buildCommand = ''
      mkdir -p $out/layouts

      cat > $out/layouts/ide.kdl <<EOF
      ${config.ide}
      EOF

      cat > $out/config.kdl <<EOF
      ${config.main}
      EOF
    '';
  }
