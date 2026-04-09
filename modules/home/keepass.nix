{ pkgs, ... }:

{
  # Install the package
  home.packages = [ pkgs.keepassxc ];

  # Configure KeePassXC (optional but recommended)
  xdg.configFile."keepassxc/keepassxc.ini".text = ''
    [General]
    ConfigVersion=2

    [GUI]
    ApplicationTheme=dark
    MinimizeOnOpen=true
    MinimizeOnClose=true
  '';
}
