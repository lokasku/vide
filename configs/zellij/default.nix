{
  pkgs,
  stdenv,
  zjstatus,
}: let
  config = pkgs.callPackage ./config {inherit zjstatus;};
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
