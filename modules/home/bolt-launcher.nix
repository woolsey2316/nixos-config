{ pkgs, ... }:

{
  home.packages = [
    # Override bolt-launcher to enable RS3
    (pkgs.bolt-launcher.override { enableRS3 = true; })
  ];
}
