{ config, pkgs, ... }:

{
  # Install ADB and Fastboot
  home.packages = with pkgs; [
    android-tools
    android-studio-full
  ];

}
