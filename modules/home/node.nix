{ pkgs, ... }: {
  home.packages = [
    pkgs.nodejs
    pkgs.pnpm
    pkgs.typescript-language-server
  ];
}
