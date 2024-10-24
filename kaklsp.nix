{
  stdenv,
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

  meta = with lib; {
    description = "Kakoune Language Server Protocol Client";
    homepage = "https://github.com/kak-lsp/kak-lsp";
    license = with licenses; [
      unlicense
      mit
    ];
    maintainers = [maintainers.spacekookie];
    mainProgram = "kak-lsp";
  };
}
