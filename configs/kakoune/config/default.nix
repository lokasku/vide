{
  pkgs,
  kakLsp,
  kks,
  selectFile,
}: {
  kakrc = pkgs.callPackage ./kakrc.nix {inherit kakLsp kks selectFile;};
  theme = import ./theme.nix;
}
