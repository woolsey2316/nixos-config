{ config, pkgs, ... }:

{
  home.username = "wools";
  home.homeDirectory = "/home/wools";
  home.stateVersion = "26.05"; # Match your release version

  home.packages = with pkgs; [
    psmisc # This provides fuser, killall, etc.
  ];
}
