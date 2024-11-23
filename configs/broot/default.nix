{stdenv}: let
  config = import ./config;
in
  stdenv.mkDerivation {
    name = "broot-config";
    src = null;
    buildCommand = ''
      mkdir -p $out

      cat > $out/conf.hjson <<EOF
      ${config.conf}
      EOF

      cat > $out/verbs.hjson <<EOF
      ${config.verbs}
      EOF

      cat > $out/theme.hjson <<EOF
      ${config.theme}
      EOF
    '';
  }
