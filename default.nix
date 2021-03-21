{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) callPackage;
in
rec {
  godot = callPackage ./pkgs/godot { };
  godotHeadless = callPackage ./pkgs/godot/headless.nix {
    godotBin = godot;
  };
  godotMono = callPackage ./pkgs/godot/mono.nix {
    godotBin = godot;
  };
}
