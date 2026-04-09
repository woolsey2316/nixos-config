{ pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles = {
      "default" = {
        isDefault = true;
        settings = {
          "mail.spellcheck.inline" = true;
          # Add other user.js settings here
        };
      };
    };
  };
}
