{ config, pkgs, ... }:

{
  # ... other configurations

  home.packages = [
    pkgs.mongodb-compass
    # ... other packages
  ];

  # ...
}
