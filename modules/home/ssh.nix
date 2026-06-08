{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "1h";
        controlMaster = "auto";
        controlPath = "~/.ssh/control-%r@%h:%p";
        controlPersist = "10m";
        forwardAgent = false;
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };

      github = {
        host = "github.com";
        hostname = "ssh.github.com";
        user = "git";
        port = 443;
        identityFile = "~/.ssh/id_github";
        identitiesOnly = true;
      };
    };
  };
  # OpenSSH strictly rejects configuration files that are symlinks pointing into the Nix store (/nix/store/...) because it perceives the Nix store's directory permissions as unsecure and outside of your exclusive user ownership.
  # Fix OpenSSH rejecting the Nix store symlink
  home.file.".ssh/config".force = true;
  home.activation = {
    fixSshPermissions = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      if [ -L "$HOME/.ssh/config" ]; then
        src="$(readlink -f "$HOME/.ssh/config")"
        run rm "$HOME/.ssh/config"
        run cp "$src" "$HOME/.ssh/config"
        run chmod 600 "$HOME/.ssh/config"
      fi
    '';
  };

  services.ssh-agent.enable = true;
}
