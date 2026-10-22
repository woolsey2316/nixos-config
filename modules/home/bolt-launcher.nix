{ pkgs, ... }:
{
  # Bolt Launcher via Flatpak (com.adamcake.Bolt) in modules/core/flatpak.nix.
  # CEF needs X11/XWayland; --socket=x11 is explicit so a global !x11 override
  # cannot strip it (Flatpak does not let per-app overrides undo global denials).
  home.packages = [
    (pkgs.writeShellScriptBin "bolt" ''
      exec flatpak run --socket=x11 --socket=fallback-x11 com.adamcake.Bolt "$@"
    '')
  ];
}
