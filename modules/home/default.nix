{ ... }:
{
  imports = [
    ./aseprite/aseprite.nix           # pixel art editor
    ./audacious/audacious.nix         # music player
    ./bat.nix                         # better cat command
    ./blueman.nix                     # bluetooth manager
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./cava.nix                        # audio visualizer
    ./chromium.nix                    # chrome browser
    ./copilot.nix                     # copilot-cli
    ./discord.nix                     # discord
    ./fastfetch/fastfetch.nix         # fetch tool
    ./firefox.nix                     # firefox developer edition
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./ghostty/ghostty.nix             # terminal
    ./git.nix                         # version control
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./keepass.nix                     # password manager
    ./kitty.nix                       # terminal
    ./lazygit.nix
    ./mongodb.nix                     # mongoDB
    ./mongodb-compass.nix             # mongoDB compass
    ./micro.nix                       # nano replacement
    ./nemo.nix                        # file manager
    ./node.nix                        # nodeJS, pnpm
    ./notepadnext.nix                 # notepad++ alternative                 
    ./nvim.nix                        # neovim editor
    ./obsidian.nix
    ./p10k/p10k.nix
    ./packages                        # other packages
    ./pomo/pomo.nix                   # TUI Pomodoro timer
    ./retroarch.nix  
    ./rofi/rofi.nix                   # launcher
    ./../../scripts/scripts.nix       # personal scripts
    ./ssh.nix                         # ssh config
    ./spicetify.nix                   # spotify client
    ./superfile/superfile.nix         # terminal file manager
    ./swaylock.nix                    # lock screen
    ./swayidle.nix                    # suspend after 5 min idle
    ./swayosd.nix                     # brightness / volume wiget
    ./swaync/swaync.nix               # notification deamon
    ./thunderbird.nix                 # email client
    ./unrar.nix                       # unrar file extractor
    ./vscodium                        # vscode fork
    ./waybar                          # status bar
    ./waypaper.nix                    # GUI wallpaper picker
    ./xdg-mimes.nix                   # xdg config
    ./zsh                             # shell
  ];
}
