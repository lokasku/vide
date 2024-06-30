{ pkgs
, lib
, stdenv
}:

let
  lazyGitConfig = pkgs.runCommand "lazy-git-config" {} ''
  mkdir -p $out

  cat > $out/config.yml <<EOF
  ${lib.readFile ./config.yml}
  EOF
  '';
in stdenv.mkDerivation {
    name = "lazy-git-config";
    buildCommand = ''
      mkdir -p $out
      cp -r ${lazyGitConfig}/* $out
    '';
  }
