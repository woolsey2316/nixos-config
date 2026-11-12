{ pkgs, ... }:

{
  # code-cursor comes from the nixpkgs-cursor overlay (see modules/core/nixpkgs.nix)
  home.packages = [
    pkgs.code-cursor
  ];
}
