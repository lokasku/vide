{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "kak-lsp";
  version = "18.0.2";

  src = fetchFromGitHub {
    owner = "kak-lsp";
    repo = "kak-lsp";
    rev = "v${version}";
    hash = "sha256-nfPc0ccEk+szaTJby56iMmydcDKDq/t1o8tw24c7MfY=";
  };

  cargoHash = "sha256-rUXyPd7YOnmYzTgpSTT7mj2viVrSwa4xB9CFRsQ8EA0=";

  meta = {
    description = "Kakoune Language Server Protocol Client";
    homepage = "https://github.com/kak-lsp/kak-lsp";
    license = with lib.licenses; [
      unlicense
      mit
    ];
    maintainers = with lib.maintainers; [spacekookie];
    mainProgram = "kak-lsp";
  };
}
