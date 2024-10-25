{}: let
  conf = ./conf.hjson;
  verbs = ./verbs.hjson;
  theme = ./theme.hjson;
in {
  inherit conf verbs theme;
}
