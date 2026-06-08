{ pkgs, ... }: {
  home.packages = [
    pkgs.nodejs
    pkgs.eas-cli
    pkgs.pnpm
    pkgs.typescript-language-server
  ];
}
