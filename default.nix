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
    export BROOT_CONFIG_DIR=${brootConfig}
    ${zellij}/bin/zellij
  '';
in
  script.overrideAttrs (p:
    p
    // {
      buildInputs = [kakoune zellij broot lazygit];
    })
