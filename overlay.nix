self: super:

let
  inherit (super) callPackage config lib;
in
{
  godotBin = callPackage ./pkgs/godot { };
  godotMonoBin = callPackage ./pkgs/godot/mono.nix { };
  godotHeadlessBin = callPackage ./pkgs/godot/headless.nix { };
}
      
