let
  black = "default";
  dark = "rgb:191919";
  gray = "rgb:5C6370";
  white = "rgb:f8f8f2";
  blue = "rgb:66D9EF";
  cyan = "rgb:8be9fd";
  aqua = "rgb:689d6a";
  green = "rgb:50fa7b";
  orange = "rgb:FFB86C";
  pink = "rgb:F879C6";
  purple = "rgb:BD93F9";
  red = "rgb:ff6565";
  yellow = "rgb:ffe765";
  dimgray = "rgb:353535";

  psel = "rgba:27374780";
  ssel = "rgba:1b273380";
in ''
  # For code
  set-face global value ${purple}
  set-face global type ${cyan}
  set-face global variable ${orange}
  set-face global module ${white}
  set-face global function ${green}
  set-face global string ${yellow}
  set-face global keyword ${pink}
  set-face global operator ${pink}
  set-face global attribute ${blue}
  set-face global bracket ${white}+b
  set-face global arguement ${orange}
  set-face global comma ${white}
  set-face global comment ${gray}+i
  set-face global docstring ${gray}+i
  set-face global meta ${pink}
  set-face global builtin ${cyan}
  set-face global class ${cyan}+b

  # For markup
  set-face global title ${pink}
  set-face global header ${orange}
  set-face global bold ${pink}
  set-face global italic ${purple}
  set-face global mono ${green}
  set-face global block ${cyan}
  set-face global link ${green}
  set-face global bullet ${green}
  set-face global list ${white}

  # Builtin faces
  set-face global Default ${white},${black}
  # set-face global Default default,default
  set-face global PrimarySelection default,${psel}
  set-face global SecondarySelection default,${ssel}
  set-face global PrimaryCursor ${dark},${purple}
  set-face global SecondaryCursor ${dark},${aqua}
  set-face global PrimaryCursorEol ${dark},${orange}
  set-face global SecondaryCursorEol ${dark},${cyan}
  set-face global LineNumbers ${gray},${black}
  set-face global LineNumberCursor ${cyan},${black}+b
  set-face global LineNumbersWrapped ${gray},${black}+i
  set-face global MenuForeground ${dark},${white}+b
  set-face global MenuBackground ${white},${dark}
  set-face global MenuInfo ${orange},${black}
  set-face global Information black,white
  set-face global Error ${red},${black}
  set-face global StatusLine ${white},${black}
  set-face global StatusLineMode ${green},${black}
  set-face global StatusLineInfo ${purple},${black}
  set-face global StatusLineValue ${orange},${black}
  set-face global StatusCursor ${white},${blue}
  set-face global Prompt ${green},${black}
  set-face global MatchingChar ${black},${blue}
  set-face global Whitespace ${dimgray},${black}+f
  set-face global WrapMarker Whitespace
  set-face global BufferPadding ${gray},${black}
''
