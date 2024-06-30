{ stdenv, lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "kak-lsp";
  version = "17.1.1";
	
  src = fetchFromGitHub {
    owner = "kak-lsp";
    repo = "kak-lsp";
    rev = "v${version}";
    hash = "sha256-XBH2pMDiHJNXrx90Lt0IcsbMFUM+X7GAHgiHpdlIdR4=";
  };

  cargoHash = "sha256-nUIoqVNTmZd4kKYO2M3lRLUcSbQF8m574sRZSlez57M=";

  meta = with lib; {
    description = "Kakoune Language Server Protocol Client";
    homepage = "https://github.com/kak-lsp/kak-lsp";
    license = with licenses; [ unlicense /* or */ mit ];
    maintainers = [ maintainers.spacekookie ];
    mainProgram = "kak-lsp";
  };
}