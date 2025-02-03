{
  writeShellApplication,
  kakoune,
  broot,
  zellij,
  lazygit,
  kakouneConfig,
  brootConfig,
  zellijConfig,
  lazyGitConfig,
}:
writeShellApplication {
  name = "vide";
  runtimeInputs = [broot kakoune lazygit zellij];
  text = ''
    export ZELLIJ_CONFIG_DIR=${zellijConfig}
    export KAKOUNE_CONFIG_DIR=${kakouneConfig}
    export LG_CONFIG_FILE=${lazyGitConfig}
    export BROOT_CONFIG_DIR=${brootConfig}
    export INIT_FILE="$1"

    zellij
  '';
}
