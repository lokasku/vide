{
  pkgs,
  lib,
  stdenv,
  kakLsp,
  kks,
}: let
  selectFile = import ./bin/select-file.nix {inherit pkgs lib kks;};
  configs = {
    "kakrc" = ''
      # LSP
      eval %sh{ ${kks}/bin/kks init }
      eval %sh{${lib.getExe kakLsp} --kakoune -s '$kak_session'}
      set global lsp_cmd "${lib.getExe kakLsp} -s %val{session} -vvv --log /tmp/kak-lsp.log"
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

      define-command broot %{
        nop %sh{
          ${lib.getExe pkgs.zellij} run --close-on-exit --floating --name select -- ${lib.getExe pkgs.broot}
        }
      }

      define-command -docstring 'Select a file to open' file-select %{
        evaluate-commands %sh{
          ${lib.getExe pkgs.zellij} run --close-on-exit --floating --name select -- ${selectFile}/bin/select-file $kak_session $kak_client "$kak_buffile"
        }
      }

      # addhl global/ show-whitespaces -nbsp "·" -tabpad "·" -indent "" -tab "-" -spc "·"
      addhl global/ number-lines -separator "  "
      addhl global/ wrap -word -indent

      colorscheme theme
    '';
    "theme.kak" = ''
      # Code
      set-face global title              default,default+bu
      set-face global header             default,default+bi
      set-face global bold               default,default+b
      set-face global italic             default,default+i
      set-face global mono               default,default
      set-face global block              default,default
      set-face global link               default,default+u
      set-face global bullet             default,default
      set-face global list               default,default

      # Markup
      set-face global value              white,default
      set-face global type               default,default+i
      set-face global variable           default,default
      set-face global module             white,default+b
      set-face global function           default,default+b
      set-face global string             white,default
      set-face global keyword            default,default+bi
      set-face global operator           white,default+d
      set-face global attribute          white,default
      set-face global comment            white,default+i
      set-face global documentation      white,default+bi
      set-face global meta               white,default
      set-face global builtin            white,default+b

      # Interface
      set-face global Default            white,default
      set-face global PrimarySelection   default,black
      set-face global SecondarySelection default,black
      set-face global PrimaryCursor      white,black+fg
      set-face global SecondaryCursor    white,black+fg
      set-face global PrimaryCursorEol   black,black+fg
      set-face global SecondaryCursorEol black,black+fg
      set-face global MenuBackground     white,default
      set-face global MenuForeground     white,default
      set-face global MenuInfo           Information
      set-face global Information        white,default
      set-face global Error              black,default
      set-face global DiagnosticError    black,default+c
      set-face global DiagnosticWarning  white,default+c
      set-face global StatusLine         default,default
      set-face global StatusLineMode     default,default
      set-face global StatusLineInfo     default,default
      set-face global StatusLineValue    default,default
      set-face global StatusCursor       white,black+fg
      set-face global Prompt             default,default
      set-face global BufferPadding      black,default
      set-face global Builtin            default,default
      set-face global LineNumbers        default,default
      set-face global LineNumberCursor   default,black+r
      set-face global LineNumbersWrapped default,default
      set-face global MatchingChar       default,default+u
      set-face global Whitespace         black,default+d
      set-face global WrapMarker         black,default+d
      set-face global Markup             default,default
    '';
  };
  kakouneConfig = pkgs.runCommand "kakoune-config" {} ''
    mkdir -p $out/colors

    cat > $out/kakrc <<EOF
    ${configs."kakrc"}
    EOF

    cat > $out/colors/theme.kak <<EOF
    ${configs."theme.kak"}
    EOF
  '';
in
  stdenv.mkDerivation {
    name = "kakoune-config";
    buildCommand = ''
      mkdir -p $out
      cp -r ${kakouneConfig}/* $out
    '';
  }
