{ pkgs, ... }: {
  # 1. Ensure the glib library package is available
  home.packages = [ pkgs.glib ];

  # 2. Export the library path directly into your shell profile
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.glib.out}/lib\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}";
  };
}
