{
  pkgs,
  kks,
}:
pkgs.writeShellScriptBin "select-file" ''
  if [ -f "$3" ]; then
      selected="$(${pkgs.broot}/bin/broot --cmd :close_preview $3)"
  else
      selected="$(${pkgs.broot}/bin/broot)"
  fi
  if [ -n "$selected" ]; then
      ${kks}/bin/kks send -s $1 -c $2 edit-or-buffer "$selected"
  else
      ${kks}/bin/kks send -s $1 -c $2 echo "no file selected"
  fi
''
