{
  colors,
  zjstatus,
  pkgs,
}: ''
  keybinds {
    normal {
      bind "Ctrl k" { CloseFocus; }
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

          tab_active              "#[fg=${colors.gray0}] {name} {floating_indicator}"
          tab_active_fullscreen   "#[fg=${colors.gray0}] {name} {fullscreen_indicator}"
          tab_active_sync         "#[fg=${colors.gray0}] {name} {sync_indicator}"

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
        pane name="Kak" command="${pkgs.kakoune}/bin/kak" size="60%"
        pane name="Cons"
      }
    }
    tab name="LazyGit" {
      pane command="${pkgs.lazygit}/bin/lazygit"
    }
  }
''
