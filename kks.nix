{
  src,
  stdenv,
  buildGoModule,
}:
buildGoModule rec {
  pname = "kks";
  version = "v0.3.8";
  inherit src;

  vendorHash = "sha256-E4D9FGTpS9NkZy6tmnuI/F4dnO9bv8MVaRstxVPvEfo=";
  subPackages = ["."];

  ldflags = ["-X main.version=${version}" "-X main.buildSource=nix"];

  postInstall = ''
    mkdir -p $out/bin
    cp -r $PWD/scripts/kks-* $out/bin
  '';

  meta = {
    mainProgram = "kks";
  };
}
