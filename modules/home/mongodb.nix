{ pkgs, ... }:

{
  home.packages = [
    pkgs.mongodb-ce # Community Edition
    # pkgs.mongodb-tools # Optional: for mongodump, mongorestore
  ];
}
