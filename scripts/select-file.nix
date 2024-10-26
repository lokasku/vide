{
  writeShellScriptBin,
  broot,
  kks,
}:
writeShellScriptBin "select-file" ''
  if [ -f "$3" ]; then
      selected="$(${broot}/bin/broot --cmd :close_preview $3)"
  else
      selected="$(${broot}/bin/broot)"
  fi
  echo "session: |$1|, client: |$2|, selected: |$selected|";
  if [ -n "$selected" ]; then
      ${kks}/bin/kks send -s $1 -c $2 edit "$selected"
  else
      ${kks}/bin/kks send -s $1 -c $2 echo -debug "Файл не выбран"
  fi
''
