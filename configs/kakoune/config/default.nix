{
  pkgs,
  kakLsp,
  kks,
  selectFile,
}: let
  kakrc = pkgs.callPackage ./kakrc.nix {inherit kakLsp kks selectFile;};
  theme = import ./theme.nix;
in {
  inherit kakrc theme;
}
