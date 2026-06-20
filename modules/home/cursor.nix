{ pkgs, ... }:

{
  # Install the cursor binary package directly
  home.packages = [
    pkgs.code-cursor
  ];
}
