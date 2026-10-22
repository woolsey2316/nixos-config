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
        # Force Wayland by default
        Context.sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
      };
      # RS clients / Wine need X11
      "com.adamcake.Bolt".Context.sockets = [
        "wayland"
        "x11"
        "fallback-x11"
      ];
    };
  };
}
