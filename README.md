# NixOS Godot Binaries
> Official Godot binary packages for NixOS

## Getting Started
The simplest way to use these packages are to use the overlay. In your `configuration.nix`:
  
    let  
      nixosGodot = fetchGit {
        url = "https://github.com/sgillespie/nixos-godot-bin.git";
      };
    in
  
    nixpkgs.overlays = nixpkgs.overlays ++ [(import "${nixosGodot}/overlay.nix)]

    # <-- Snip -->
    environment.systemPackages = with pkgs; [
      godotBin
      godotMonoBin
      godotHeadlessBin
    ]
