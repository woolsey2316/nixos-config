{ pkgs, ... }:
{
  # Bolt Launcher via Flatpak (com.adamcake.Bolt) in modules/core/flatpak.nix.
  home.packages = [
    (pkgs.writeShellScriptBin "bolt" ''
      exec flatpak run --socket=x11 --branch=stable --arch=x86_64 --command=bolt com.adamcake.Bolt "$@"
    '')
  ];

  # Override Flatpak's .desktop so the app menu also passes --socket=x11
  # (same args as `flatpak run --socket=x11 ...`, which works).
  xdg.desktopEntries."com.adamcake.Bolt" = {
    name = "Bolt";
    genericName = "Bolt Launcher";
    comment = "Third-party Jagex launcher";
    exec = "bolt";
    icon = "com.adamcake.Bolt";
    categories = [ "Game" ];
    terminal = false;
    settings = {
      StartupWMClass = "com.adamcake.Bolt";
      Keywords = "games;";
    };
  };
}
