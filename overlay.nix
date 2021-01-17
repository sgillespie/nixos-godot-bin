self: super:

let
  inherit (super) callPackage config lib;
in
{
  godotBin = callPackage ./pkgs/godot { };
  godotMono = callPackage ./pkgs/godot/mono.nix { };
  godotHeadless = callPackage ./pkgs/godot/headless.nix { };
}
      
