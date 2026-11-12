{ pkgs, inputs, ... }:
{
  nixpkgs = {
    config.android_sdk.accept_license = true;
    overlays = [
      (
        final: prev:
        (import ../../pkgs {
          inherit inputs;
          inherit pkgs;
          inherit (prev) system;
        })
      )
      # Pull a newer Cursor from a pinned nixpkgs without bumping the whole system
      (
        final: prev: {
          code-cursor =
            (import inputs.nixpkgs-cursor {
              inherit (prev) system;
              config.allowUnfree = true;
            }).code-cursor;
        }
      )
    ];
  };
}
