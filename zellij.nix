{ pkgs
, lib
, stdenv

, zjstatus
, helixConfig
}:

let
  colors = {
    fg = "#f0e6ff";
    bg = "#161616";
    black = "#000000";
    red = "#ff6961";
    green = "#636363";
    yellow = "#fff261";
    blue = "#9b99ff";
    magenta = "#da9fff";
    cyan = "#70d7ff";
    white = "#f2f2f7";
    orange = "#ff9f0a";
    gray0 = "8e8e93";
    gray1 = "#636363";
    gray2 = "#3a3a3c";
    gray3 = "#242426";
  };
  configs = {
    "config.kdl" = ''
    plugins {
      zjstatus { path "zjstatus"; }
    }

    ui {
      pane_frames {
        rounded_corners true
      }
    }

    theme "default"

    themes {
      default {
        fg "${colors.fg}"
        bg "${colors.bg}"
        black "${colors.black}"
        red "${colors.red}"
        green "${colors.green}"
        yellow "${colors.yellow}"
        blue "${colors.blue}"
        magenta "${colors.magenta}"
        cyan "${colors.cyan}"
        white "${colors.white}"
        orange "${colors.orange}"
      }
    }

    auto_layout true
    default_layout "ide"
    '';

    "ide.kdl" = ''
    keybinds {
      normal {
        bind "Ctrl k" { CloseFocus; }
        bind "Ctrl g" {
          Run "${lib.getExe pkgs.lazygit}";
          SwitchToMode "Normal";
          TogglePaneEmbedOrFloating;
          Resize "Increase Left"; Resize "Increase Left"; Resize "Increase Left"; Resize "Increase Left"; Resize "Increase Left";
          Resize "Increase Right"; Resize "Increase Right"; Resize "Increase Right"; Resize "Increase Right"; Resize "Increase Right";
          Resize "Increase Down"; Resize "Increase Down"; Resize "Increase Down"; Resize "Increase Down"; Resize "Increase Down";
          Resize "Increase Up"; Resize "Increase Up"; Resize "Increase Up"; Resize "Increase Up"; Resize "Increase Up";
        }
      }
    }
    layout {
      swap_tiled_layout name="horizontal" borderless=true {
        tab max_panes=2 {
          pane split_direction="horizontal" {
            pane
          }
        }
      }
      default_tab_template {
        children

        pane size=1 borderless=true {
          plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
            format_left   "{mode} #[fg=${colors.magenta},bold] {session}"
            format_center "{tabs}"
            format_right  "{command_git_branch} {datetime}"
            format_space  ""

            border_enabled  "false"
            hide_frame_for_single_pane "false"

            mode_normal        "#[bg=${colors.gray3}] {name} "
            mode_locked        "#[bg=${colors.gray3}] {name} "
            mode_resize        "#[bg=${colors.gray3}] {name} "
            mode_pane          "#[bg=${colors.gray2}] {name} "
            mode_tab           "#[bg=${colors.gray3}] {name} "
            mode_scroll        "#[bg=${colors.gray3}] {name} "
            mode_enter_search  "#[bg=${colors.gray3}] {name} "
            mode_search        "#[bg=${colors.gray3}] {name} "
            mode_rename_tab    "#[bg=${colors.gray3}] {name} "
            mode_rename_pane   "#[bg=${colors.gray3}] {name} "
            mode_session       "#[bg=${colors.gray3}] {name} "
            mode_move          "#[bg=${colors.gray3}] {name} "
            mode_prompt        "#[bg=${colors.gray3}] {name} "
            mode_tmux          "#[bg=${colors.gray3}] {name} "
            mode_default_to_mode "tmux"

            tab_normal              "#[fg=${colors.gray1}] {name} "
            tab_normal_fullscreen   "#[fg=${colors.gray1}] {name} [] "
            tab_normal_sync         "#[fg=${colors.gray1}] {name} <> "

            tab_active              "#[fg=${colors.gray0},italic] {name} {floating_indicator}"
            tab_active_fullscreen   "#[fg=${colors.gray0},italic] {name} {fullscreen_indicator}"
            tab_active_sync         "#[fg=${colors.gray0},italic] {name} {sync_indicator}"

            tab_separator           "   "

            tab_rename              "#[fg=${colors.cyan}] {name} {floating_indicator} "

            tab_sync_indicator       ""
            tab_fullscreen_indicator ""
            tab_floating_indicator   ""
            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "#[fg=blue] {stdout} "
            command_git_branch_interval    "10"
            command_git_branch_rendermode  "static"

            datetime          "#[fg=#6C7086,bold] {format} "
            datetime_format   "%l:%-M'%-S"
            datetime_timezone "Europe/Paris"
          }
        }
      }
      tab name="Code" focus=true {
        pane split_direction="vertical" {
          pane name="Hex" command="${lib.getExe pkgs.helix}" size="60%" {
            args "-c" "${helixConfig}/config.toml" 
          }
          pane name="Cons"
        }
      }
    }
    '';
    # pane split_direction="vertical" {
    #   pane name="Kak" command="${lib.getExe pkgs.kakoune}" size="60%"
    #   pane name="term"
    # }

    # pane name="Hex" command="${lib.getExe pkgs.kakoune}" size="60%" {
    #   args "-c" "${helixConfig}/config.toml" 
    # }
  };
  zellijConfig = pkgs.runCommand "zellij-config" {} ''
    mkdir -p $out/layouts

    cat > $out/layouts/ide.kdl <<EOF
    ${configs."ide.kdl"}
    EOF
    cat > $out/config.kdl <<EOF
    ${configs."config.kdl"}
    EOF
  '';
in stdenv.mkDerivation {
    name = "zellij-config";
    buildCommand = ''
      mkdir -p $out
      cp -r ${zellijConfig}/* $out
    '';
  }
