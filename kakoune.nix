{ pkgs
, lib
, stdenv
}:

let
  colors = {
    white = "rgb:ffffff";
    whitedim = "rgb:c0c0c0";
    black = "rgb:000000";
    orange = "rgb:ff9f0a";
    red = "rgb:ff6961";
    yellow = "rgb:fff261";
    blue = "rgb:9b99ff";
    magenta = "rgb:da9fff";
    cyan = "rgb:70d7ff";

    gray0 = "rgb:8e8e93";
    gray1 = "rgb:636363";
    
    c5 = "rgb:9b99ff";
    c4 = "rgb:70d7ff";
    c3 = "rgb:9bb3ff";
    c2 = "rgb:b29bff";
    c1 = "rgb:cf9fff";
    c0 = "rgb:da9fff";

    sel = "rgba:508aa81f";
    sel2 = "rgba:508aa81f";
    sel_cursor = "rgba:508aa81f";
    sel_cursor_eol = "rgba:508aa81f";
  };
  configs = {
    "kakrc" = ''
      # LSP
      eval %sh{${lib.getExe pkgs.kak-lsp} --config ./kaklsp/kak-lsp.toml --kakoune -s $kak_session}
      lsp-enable

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
          ${pkgs.zellij}/bin/zellij run --close-on-exit --floating --name select -- ${pkgs.broot}/bin/broot
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
      set-face global value              ${colors.c0},default
      set-face global type               default,default+i
      set-face global variable           default,default
      set-face global module             ${colors.cyan},default+b
      set-face global function           default,default+b
      set-face global string             ${colors.c2},default
      set-face global keyword            default,default+bi
      set-face global operator           ${colors.c3},default+d
      set-face global attribute          ${colors.cyan},default
      set-face global comment            ${colors.c1},default+i
      set-face global documentation      ${colors.c2},default+bi
      set-face global meta               ${colors.c4},default
      set-face global builtin            ${colors.c5},default+b

      # Deprecated?
      # set-face global error              ${colors.c4},default+c
      # set-face global identifier         default,default

      # Interface
      set-face global Default            ${colors.white},default
      set-face global PrimarySelection   default,${colors.sel}
      set-face global SecondarySelection default,${colors.sel2}
      set-face global PrimaryCursor      ${colors.c4},${colors.sel_cursor}+fg
      set-face global SecondaryCursor    ${colors.c4},${colors.sel_cursor}+fg
      set-face global PrimaryCursorEol   ${colors.black},${colors.sel_cursor_eol}+fg
      set-face global SecondaryCursorEol ${colors.black},${colors.sel_cursor_eol}+fg
      set-face global MenuBackground     ${colors.white},default
      set-face global MenuForeground     ${colors.white},default
      set-face global MenuInfo           Information
      set-face global Information        ${colors.white},default
      set-face global Error              ${colors.red},default
      set-face global DiagnosticError    ${colors.red},default+c
      set-face global DiagnosticWarning  ${colors.orange},default+c
      set-face global StatusLine         default,default
      set-face global StatusLineMode     default,default
      set-face global StatusLineInfo     default,default
      set-face global StatusLineValue    default,default
      set-face global StatusCursor       ${colors.c4},${colors.sel_cursor}+fg
      set-face global Prompt             default,default
      set-face global BufferPadding      ${colors.gray1},default
      set-face global Builtin            default,default
      set-face global LineNumbers        default,default
      set-face global LineNumberCursor   default,${colors.red}+r
      set-face global LineNumbersWrapped default,default
      set-face global MatchingChar       default,default+u
      set-face global Whitespace         ${colors.gray0},default+d
      set-face global WrapMarker         ${colors.gray0},default+d
      set-face global Markup             default,default
      }
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
in stdenv.mkDerivation {
    name = "kakoune-config";
    buildCommand = ''
      mkdir -p $out
      cp -r ${kakouneConfig}/* $out
    '';
  }
