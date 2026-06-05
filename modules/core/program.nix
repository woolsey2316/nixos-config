{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    zsh.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = "";
    };

    appimage.enable = true;

    # for Expo, React native apps
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      expat
      libgbm
      pango
      alsa-lib
      libxkbcommon
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libXcursor
      glib
      gtk3
      xorg.libX11
      nss
      nspr
      dbus
      atk
      cups
      cairo
    ];
  };
}
