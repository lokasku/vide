{
  pkgs,
  kakLsp,
  kks,
  kakouneConfig,
  brootConfig,
  zellijConfig,
  lazyGitConfig,
}:
pkgs.writeShellScriptBin "vide" ''
  export ZELLIJ_CONFIG_DIR=${zellijConfig}
  export KAKOUNE_CONFIG_DIR=${kakouneConfig}
  export BROOT_CONFIG_DIR=${brootConfig}
  export LG_CONFIG_FILE=${lazyGitConfig}
  ${pkgs.zellij}/bin/zellij
''
