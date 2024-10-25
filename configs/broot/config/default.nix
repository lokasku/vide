{
  conf = builtins.readFile ./conf.hjson;
  verbs = builtins.readFile ./verbs.hjson;
  theme = builtins.readFile ./theme.hjson;
}
