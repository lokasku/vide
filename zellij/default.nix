{ pkgs
, lib
, zellij
, stdenv

, zjstatus
}:

let
  configs = {
    "config.kdl" = ''
    plugins {
      zjstatus { path "zjstatus"; }
    }

    auto_layout true
    theme "tokyo-night-dark"
    default_layout "ide"
    '';
    "ide.kdl" = ''
    layout {
      default_tab_template {
        children

        pane size=1 borderless=true {
          plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
              format_left   "{mode} #[fg=#89B4FA,bold]{session}"
              format_center "{tabs}"
              format_right  "{command_git_branch} {datetime}"
              format_space  ""

              border_enabled  "false"
              border_char     "-"
              border_format   "#[fg=#6C7086]{char}"
              border_position "top"

              hide_frame_for_single_pane "false"

              mode_normal  "#[bg=blue] "
              mode_tmux    "#[bg=#ffc387] "

              tab_normal   "#[fg=#6C7086] {name} "
              tab_active   "#[fg=#9399B2,bold,italic] {name} "

              command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
              command_git_branch_format      "#[fg=blue] {stdout} "
              command_git_branch_interval    "10"
              command_git_branch_rendermode  "static"

              datetime        "#[fg=#6C7086,bold] {format} "
              datetime_format "%A, %d %b %Y %H:%M"
              datetime_timezone "Europe/Paris"
            }
        }
      }
    }
    '';
  };
  zellijConfig = pkgs.runCommand "zellij-config" {
    nativeBuildInputs = [ pkgs.zellij ];
  } ''
    mkdir -p $out/layouts
    cat > $out/layouts/ide.kdl <<EOF
    ${configs."ide.kdl"}
    EOF
    cat > $out/config.kdl <<EOF
    ${configs."config.kdl"}
    EOF
  '';
in
  stdenv.mkDerivation {
    name = "zellij-config";
    buildInputs = [ zellij ];
    buildCommand = ''
      mkdir -p $out/share/zellij
      cp -r ${zellijConfig}/* $out/share/zellij/
    '';
  }