{
  description = "Official Godot binary packages for NixOS - An overlay for Godot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        rec {
          defaultPackage = packages.godot;
          packages.godot = pkgs.callPackage ./pkgs/godot { };
          packages.godotHeadless = pkgs.callPackage ./pkgs/godot/headless.nix {
            godotBin = packages.godot;
          };
          packages.godotMono = pkgs.callPackage ./pkgs/godot/mono.nix {
            godotBin = packages.godot;
          };
        }
      );
}
