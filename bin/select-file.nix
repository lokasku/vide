{
  pkgs,
  lib,
  kks,
}:
pkgs.writeShellScriptBin "select-file" ''
  #!/usr/bin/env bash

  if [ -f "$3" ]; then
      selected="$(${lib.getExe pkgs.broot} --cmd :close_preview $3)"
  else
      selected="$(${lib.getExe pkgs.broot})"
  fi
  if [ -n "$selected" ]; then
      ${kks}/bin/kks send -s $1 -c $2 edit-or-buffer "$selected"
  else
      ${kks}/bin/kks send -s $1 -c $2 echo "no file selected"
  fi
''
