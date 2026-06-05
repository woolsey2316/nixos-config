{ config, pkgs, ... }:

let
  androidStudioFHS = pkgs.buildFHSEnv {
    name = "android-studio";
    targetPkgs = pkgs: with pkgs; [
      android-studio
      android-tools 
      glibc
      libglvnd
      glib
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      fontconfig
      freetype
      zlib
    ];
    runScript = "${pkgs.android-studio}/bin/android-studio";
  };
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    androidStudioFHS
    pkgs.android-tools 
  ];

  # --- ADD THIS BLOCK TO CREATE THE APP SHORTCUT ---
  xdg.enable = true; # Ensures XDG directories are actively managed
  xdg.desktopEntries = {
    android-studio = {
      name = "Android Studio";
      genericName = "Integrated Development Environment";
      comment = "Android Studio (FHS Mode for NixOS)";
      
      # Points directly to the custom environment executable we built above
      exec = "${androidStudioFHS}/bin/android-studio"; 
      
      # Extracts the genuine default icon directly out of the nix package
      icon = "${pkgs.android-studio}/share/pixmaps/android-studio.svg";
      
      terminal = false;
      categories = [ "Development" "IDE" ];
      mimeType = [ "application/x-studio-project" ];
    };
  };

  home.sessionVariables = {
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
  };
}
