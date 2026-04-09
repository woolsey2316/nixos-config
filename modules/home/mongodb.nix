{ config, pkgs, ... }:

{
  # Allow unfree packages (required for newer MongoDB)
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.mongodb-ce # Community Edition
    # pkgs.mongodb-tools # Optional: for mongodump, mongorestore
  ];

  # ... rest of your config
}
