{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) callPackage;
in
rec {
  godot = callPackage ./pkgs/godot { };
  godotHeadless = callPackage ./pkgs/godot/headless.nix {
  };
  godotMono = callPackage ./pkgs/godot/mono.nix {
    godot = godot;
  };
}
