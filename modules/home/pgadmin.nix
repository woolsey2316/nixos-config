{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pgadmin4-desktopmode
  ];

  xdg.desktopEntries.pgadmin4 = {
    name = "pgAdmin 4";
    exec = "ghostty -e pgadmin4";
    icon = "pgadmin4";
    comment = "Administration and development platform for PostgreSQL";
    categories = [ "Development" "Database" ];
  };
}
