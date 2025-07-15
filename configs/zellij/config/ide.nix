{
  colors,
  zjstatus,
  kks, # temp
  pkgs,
}:
''
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
          format_right  "{command_git_branch} "
          format_space  ""

          border_enabled  "false"
          hide_frame_for_single_pane "false"

          mode_normal        "#[bold] {name} "
          mode_locked        "#[bg=${colors.red}] {name} "
          mode_resize        " {name} "
          mode_pane          " {name} "
          mode_tab           " {name} "
          mode_scroll        " {name} "
          mode_enter_search  " {name} "
          mode_search        " {name} "
          mode_rename_tab    " {name} "
          mode_rename_pane   " {name} "
          mode_session       " {name} "
          mode_move          " {name} "
          mode_prompt        " {name} "
          mode_tmux          " {name} "

          mode_default_to_mode "tmux"

          tab_normal              "#[fg=${colors.gray1}] {name} "
          tab_normal_fullscreen   "#[fg=${colors.gray1}] {name} [] "
          tab_normal_sync         "#[fg=${colors.gray1}] {name} <> "

          tab_active              "#[fg=${colors.gray0}] {name}"
          tab_active_fullscreen   "#[fg=${colors.gray0}] {name}"
          tab_active_sync         "#[fg=${colors.gray0}] {name}"

          tab_separator           "   "

          tab_rename              "{name}"

          command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
          command_git_branch_format      "#[fg=blue] {stdout} "
          command_git_branch_interval    "10"
          command_git_branch_rendermode  "static"
        }
      }
    }
    tab name="Code" focus=true {
      pane split_direction="vertical" {
        pane {
          name "Kak"
          size "60%"
          command "${kks}/bin/kks"
          args "edit"
        }
        pane name="Term"
      }
    }
    tab name="LazyGit" {
      pane command="lazygit"
    }
  }
''
