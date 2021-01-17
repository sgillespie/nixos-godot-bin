{
  pkgPath ? <nixpkgs>,
  overlays ? (import <nixpkgs/nixos> { }).config.nixpkgs.overlays
}:

let
  overlay = import ./overlay.nix;
  pkgs = import pkgPath { overlays = [overlay] ++ overlays; };
  inherit (pkgs) mkShell;
in
  mkShell {
    buildInputs = with pkgs; [
      godot
      godotHeadless
      godotMono
    ];
  }
