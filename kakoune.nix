{ pkgs
, lib
, stdenv
}:
let
  colors = {
    white = "rgb:ffffff";
    black = "rgb:000000";
    orange = "rgb:ff9f0a";
    red = "rgb:ff6961";
    yellow = "rgb:fff261";
    blue = "rgb:9b99ff";
    magenta = "rgb:da9fff";
    cyan = "rgb:70d7ff";

    green5 = "rgb:25a244";
    green4 = "rgb:2dc653";
    green3 = "rgb:4ad66d";
    green2 = "rgb:6ede8a";
    green1 = "rgb:92e6a7";
    green0 = "rgb:b7efc5";

    sel = "rgba:508aa81f";
    sel2 = "rgba:508aa81f";
    sel_cursor = "rgba:508aa81f";
    sel_cursor_eol = "rgba:508aa81f";
  };
  configs = {
    "kakrc" = ''
      set-option global tabstop 4
      set-option global indentwidth 4

      addhl global/ show-whitespaces -nbsp "·" -tabpad "·" -indent "" -tab "-" -spc "·"
      addhl global/ number-lines -hlcursor -separator "   "
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
      set-face global value              ${colors.green0},default
      set-face global type               default,default+i
      set-face global variable           default,default
      set-face global module             default,default+b
      set-face global function           default,default+b
      set-face global string             ${colors.green2},default
      set-face global keyword            default,default+i
      set-face global operator           ${colors.green3},default+d
      set-face global attribute          default,default
      set-face global comment            ${colors.green1},default+i
      set-face global documentation      ${colors.green2},default+bi
      set-face global meta               ${colors.green4},default
      set-face global builtin            ${colors.green5},default+b

      # Deprecated?
      # set-face global error              ${colors.green4},default+c
      # set-face global identifier         default,default

      # Interface
      set-face global Default            ${colors.white},default
      set-face global PrimarySelection   default,${colors.sel}
      set-face global SecondarySelection default,${colors.sel2}
      set-face global PrimaryCursor      ${colors.green4},${colors.sel_cursor}+fg
      set-face global SecondaryCursor    ${colors.green4},${colors.sel_cursor}+fg
      set-face global PrimaryCursorEol   ${colors.black},${colors.sel_cursor_eol}+fg
      set-face global SecondaryCursorEol ${colors.black},${colors.sel_cursor_eol}+fg
      set-face global MenuBackground     ${colors.blue},default
      set-face global MenuForeground     +r@MenuBackground
      set-face global MenuInfo           Information
      set-face global Information        ${colors.cyan},default
      set-face global Error              ${colors.red},default
      set-face global DiagnosticError    ${colors.red},default+c
      set-face global DiagnosticWarning  ${colors.orange},default+c
      set-face global StatusLine         default,default
      set-face global StatusLineMode     default,default
      set-face global StatusLineInfo     default,default
      set-face global StatusLineValue    default,default
      set-face global StatusCursor       ${colors.green4},${colors.sel_cursor}+fg
      set-face global Prompt             default,default
      set-face global BufferPadding      ${colors.blue},default
      set-face global Builtin            default,default
      set-face global LineNumbers        ${colors.white},default
      set-face global LineNumberCursor   ${colors.white},default+r
      set-face global LineNumbersWrapped ${colors.white},default
      set-face global MatchingChar       default,default+u
      set-face global Whitespace         ${colors.green1},default+d
      set-face global WrapMarker         ${colors.green1},default+d
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