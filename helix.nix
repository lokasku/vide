{ pkgs
, lib
, stdenv
}:

let
  config = ''
  theme = "base16_transparent"

  [editor]
  scrolloff = 10
  line-number = "absolute"
  bufferline = "multiple"
  popup-border = "popup"

  [editor.statusline]
  left = ["mode", "spinner"]
  center = ["file-name", "file-modification-indicator"]
  right = ["diagnostics", "read-only-indicator", "file-type", "register", "position", "file-encoding"]
  '';
  helixConfig = pkgs.runCommand "helix-config" {} ''
  mkdir -p $out

  cat > $out/config.toml <<EOF
  ${config}
  EOF
  '';
in stdenv.mkDerivation {
    name = "helix-config";
    buildCommand = ''
      mkdir -p $out
      cp -r ${helixConfig}/* $out
    '';
  }
