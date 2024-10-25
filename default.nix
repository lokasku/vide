# {
#   pkgs,
#   kakLsp,
#   kks,
#   kakouneConfig,
#   brootConfig,
#   zellijConfig,
#   lazyGitConfig,
# }:
# pkgs.stdenv.mkDerivation {
#   name = "vide";
#   buildInputs = [pkgs.kakoune pkgs.zellij pkgs.broot pkgs.lazygit];
#   buildCommand = ''
#     mkdir -p $out/bin
#     cat > $out/bin/vide <<EOF
#     #!/usr/bin/env bash
#     export EDITOR='${kks}/bin/kks edit'
#     export ZELLIJ_CONFIG_DIR=${zellijConfig}
#     export KAKOUNE_CONFIG_DIR=${kakouneConfig}
#     export LG_CONFIG_FILE=${lazyGitConfig}
#     ${pkgs.zellij}/bin/zellij
#     EOF
#     chmod +x $out/bin/vide
#   '';
# }
# pkgs.writeShellScriptBin "vide" ''
#   export EDITOR='${kks}/bin/kks edit'
#   export ZELLIJ_CONFIG_DIR=${zellijConfig}
#   export KAKOUNE_CONFIG_DIR=${kakouneConfig}
#   export LG_CONFIG_FILE=${lazyGitConfig}
#   alias kks='${kks}/bin/kks'
#   echo ${brootConfig}
#   ${kks}/bin/kks --help
#   ${pkgs.zellij}/bin/zellij
# ''
# #   export BROOT_CONFIG_DIR=${brootConfig}
{
  writeShellScriptBin,
  kakoune,
  broot,
  zellij,
  lazygit,
  kakLsp,
  kks,
  kakouneConfig,
  brootConfig,
  zellijConfig,
  lazyGitConfig,
}: let
  script = writeShellScriptBin "vide" ''
    export ZELLIJ_CONFIG_DIR=${zellijConfig}
    export KAKOUNE_CONFIG_DIR=${kakouneConfig}
    export LG_CONFIG_FILE=${lazyGitConfig}
    ${zellij}/bin/zellij
  '';
in
  script.overrideAttrs (p:
    p
    // {
      propagatedBuildInputs = [kakoune zellij broot lazygit];
    })
