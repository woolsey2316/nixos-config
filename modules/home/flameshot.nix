{ config, ... }:
{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        showHelp = false;
        savePath = "/home/wools/Pictures/Screenshots";
        uiColor = "#7aa2f7";
      };
    };
  };

  # Native Wayland support for Hyprland
  systemd.user.services.flameshot.Service.Environment = [
    "QT_QPA_PLATFORM=wayland"
  ];
}
