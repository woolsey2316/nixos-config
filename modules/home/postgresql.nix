{ pkgs, ... }: {
  home.packages = with pkgs; [
    postgresql      # Includes psql, initdb, pg_ctl
    pgcli           # Optional: excellent auto-completing CLI
  ];
}
