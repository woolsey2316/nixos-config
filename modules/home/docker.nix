{ pkgs, ... }: {
  # Enable the Docker daemon
  virtualisation.docker.enable = true;

  # (Optional) Enable rootless mode for better security
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Add your user to the "docker" group to use docker without sudo
  users.users.wools.extraGroups = [ "docker" ];
}
