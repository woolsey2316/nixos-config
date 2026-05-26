{ pkgs, config, lib, ... }:
let
  # Adjust to your preferred Postgres version if needed
  postgresPkg = pkgs.postgresql;
  dataDir = "${config.home.homeDirectory}/.local/share/postgres/data";
in
{
  # Ensure the data directory exists
  home.activation.createPostgresDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${dataDir}
  '';

  systemd.user.services.postgresql = {
    Unit = {
      Description = "PostgreSQL user-level server";
      After = [ "network.target" ];
    };

    Service = {
      ExecStartPre = "${postgresPkg}/bin/initdb -D ${dataDir} --no-locale";
      ExecStart = "${postgresPkg}/bin/postgres -D ${dataDir}";
      ExecStop = "${postgresPkg}/bin/pg_ctl stop -D ${dataDir} -m fast";
      Restart = "always";
      RestartSec = "5";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
