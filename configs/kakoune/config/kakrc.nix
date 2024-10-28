{
  pkgs,
  kakLsp,
  kks,
  selectFile,
}: ''
  eval %sh{${kks}/bin/kks init}
  eval %sh{${kakLsp}/bin/kak-lsp --kakoune -s '$kak_session'}
  set global lsp_cmd "${kakLsp}/bin/kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
  lsp-enable
  lsp-auto-hover-enable
  set global lsp_hover_anchor true

  set-option global lsp_diagnostic_line_error_sign ''
  set-option global lsp_diagnostic_line_warning_sign ''
  set-option global lsp_diagnostic_line_info_sign ''
  set-option global lsp_diagnostic_line_hint_sign ''

  lsp-inlay-hints-enable global
  lsp-inlay-diagnostics-enable global
  # lsp-auto-hover-enable global

  # Misc
  set-option global tabstop 4
  set-option global indentwidth 4
  set-option global modelinefmt '%val{bufname} %val{cursor_line}:%val{cursor_char_column} {{context_info}} {{mode_info}}'
  set-option global ui_options \
  terminal_assistant=clippy \
  terminal_status_on_top=false \
  terminal_set_title=false \
  terminal_enable_mouse=true \
  terminal_change_colors=true \
  terminal_padding_char="·" \

  define-command -docstring 'Select a file to open' file-select %{
      evaluate-commands %sh{
          zellij run --close-on-exit --name select --in-place -- ${selectFile}/bin/select-file session0 client0 "$kak_buffile"
      }
  }

  define-command edit-or-buffer -params 0.. %{
      evaluate-commands %sh{
          if [ -n "$1" ]; then
              if [ -e "$2" ] || [ "$2" -eq 0 ]; then
                  for buf in "$kak_buflist"; do
                      if [ "$buf" == "$1" ]; then
                          echo buffer "$1"
                          exit
                      fi
                  done
                  echo edit "$1"
              else
                  echo edit "$1" "$2"
              fi
          fi
      }
  }

  # addhl global/ show-whitespaces -nbsp "·" -tabpad "·" -indent "" -tab "-" -spc "·"
  addhl global/ number-lines -separator "  "
  addhl global/ wrap -word -indent

  rename-session session0
  rename-client client0

  colorscheme theme
''
