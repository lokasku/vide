{
  pkgs,
  zjstatus,
  kks, # temp
}: let
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
in {
  ide = pkgs.callPackage ./ide.nix {inherit colors zjstatus kks;};
  main = import ./main.nix {inherit colors;};
}
