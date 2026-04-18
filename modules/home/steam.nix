{ pkgs, ... }: {
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for remote play
    dedicatedServer.openFirewall = true; # Open ports for source dedicated server
  };

  # Allow unfree packages (Steam is unfree)
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];
}
