{
  pkgs,
  stdenv,
  kakLsp,
  kks,
  selectFile,
}: let
  # selectFile = pkgs.callPackage ../../scripts/select-file.nix {inherit kks;};
  config = pkgs.callPackage ./config {inherit kakLsp kks selectFile;};
in
  stdenv.mkDerivation {
    name = "kakoune-config";
    src = null;
    buildCommand = ''
      mkdir -p $out/colors

      cat > $out/kakrc <<EOF
      ${config.kakrc}
      EOF

      cat > $out/colors/theme.kak <<EOF
      ${config.theme}
      EOF
    '';
  }
