{ stdenv
, fetchurl
}:

stdenv.mkDerivation {
  pname = "kks";
  version = "0.3.8";
  src = fetchurl {
    url = "https://github.com/kkga/kks/archive/refs/tags/v0.3.8.tar.gz";
    sha256 = "sha256-AGtEwNay9XJ5HlJe7Rhtb4QjyeuBGG7VdE771gPt2sg=";
  };
  buildPhase = ''
    mkdir -p $out/bin
    cp -r $PWD/scripts/kks-* $out/bin
  '';
}