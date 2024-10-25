{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  name = "broot-config";
  src = null;
  buildCommand = ''
    mkdir -p $out/config

    cat > $out/config/conf.hjson <<EOF
    # hello
    EOF
  '';
}
