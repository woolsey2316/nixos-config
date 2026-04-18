{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ]; # used for bolt-launcher
  powerManagement.cpuFreqGovernor = "performance";
}
