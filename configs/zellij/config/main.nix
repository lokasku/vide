{colors}: ''
  plugins {
    zjstatus { path "zjstatus"; }
  }

  ui {
    pane_frames {
      rounded_corners true
      styled_underlines true
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
''
