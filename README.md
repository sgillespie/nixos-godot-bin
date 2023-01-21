# NixOS Godot Binaries

> Official Godot binary packages for NixOS
(including godot-mono for C# support!)

## Getting Started

### Without Flakes ❄❌

The simplest way to use these packages are to use the overlay. In your `configuration.nix`:
  
    let  
      nixosGodot = fetchGit {
        url = "https://github.com/sgillespie/nixos-godot-bin.git";
      };
    in
  
    nixpkgs.overlays = nixpkgs.overlays ++ [(import "${nixosGodot}/overlay.nix)"]

    # <-- Snip -->
    environment.systemPackages = with pkgs; [
      godotBin
      godotMonoBin
      godotHeadlessBin
    ]

### With Flakes ❄✅

#### Running Godot without installing it

To run Godot without any further configuration, run this command:

```
nix run github:Quoteme/nixos-godot-bin
```

##### Running different Godot flavors

There are also these other options available to run Godot:

```
nix run github:Quoteme/nixos-godot-bin\#godot
nix run github:Quoteme/nixos-godot-bin\#godotHeadless
nix run github:Quoteme/nixos-godot-bin\#godotMono
```

Most importantly, using `\#godotMono` will allow you to write in C#.

#### Installing Godot using flakes system-wide

Put this in your `flake.nix`, to install Godot for your user:

```
  inputs = {
    # ...
    godot.url = "github:Quoteme/nixos-godot-bin";
    # ...
  };

  outputs = { self, nixpkgs, ... }@attrs:
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ({ config, nixpkgs, ...}@inputs:
          users.users.YOURUSERNAME.packages = [
            # ...
            inputs.godot.packages.x86_64-linux.godot # for godot without Mono / C#
            inputs.godot.packages.x86_64-linux.godotHeadless # for godot headless
            inputs.godot.packages.x86_64-linux.godotMono
          ]
        )
      ]
```

Alternatively you can also install Godot system-wide like this:

```
  inputs = {
    # ...
    godot.url = "github:Quoteme/nixos-godot-bin";
    # ...
  };

  outputs = { self, nixpkgs, ... }@attrs:
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ({ config, nixpkgs, ...}@inputs:
          environment.systemPackages = [
            # ...
            inputs.godot.packages.x86_64-linux.godot # for godot without Mono / C#
            inputs.godot.packages.x86_64-linux.godotHeadless # for godot headless
            inputs.godot.packages.x86_64-linux.godotMono
          ]
        )
      ]
```
