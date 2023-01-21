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
          # This section is here, so users can run:
          # > nix run github:Quoteme/nixos-godot-bin
          # and start Godot without any further configuration.
          #
          # > nix run github:Quoteme/nixos-godot-bin\#godot
          # > nix run github:Quoteme/nixos-godot-bin\#godotHeadless
          # > nix run github:Quoteme/nixos-godot-bin\#godotMono
          # are also available.
          defaultApp = apps.godot;
          apps.godot = {
            type = "app";
            program = "${packages.godot}/bin/godot";
          };
          apps.godotHeadless = {
            type = "app";
            program = "${packages.godot}/bin/godot-headless";
          };
          apps.godotMono = {
            type = "app";
            program = "${packages.godotMono}/bin/godot-mono";
          };

          # This is for installing Godot using flakes
          # just add this flake to your flakes inputs, and then you can
          # use these packages to include Godot in your environment.
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
