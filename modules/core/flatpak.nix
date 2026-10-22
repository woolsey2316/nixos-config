{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "com.mongodb.Compass"
      "com.adamcake.Bolt"
    ];
    overrides = {
      global = {
        # Prefer Wayland when available. Do not deny x11 here — Flatpak's
        # global !x11 cannot be re-enabled per-app, and CEF apps (Bolt) crash
        # without XWayland (Missing X server / $DISPLAY).
        Context.sockets = [ "wayland" ];
      };
      # Bolt's CEF UI + Wine/RS clients need X11/XWayland
      "com.adamcake.Bolt".Context.sockets = [
        "wayland"
        "x11"
        "fallback-x11"
      ];
    };
  };
}
