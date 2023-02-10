# Fission Tools Overlay

This repository provides a nix overlay for using various Fission tools.

## Usage

### Nix Channel

Add this overlay as a nix channel

Run `nix-channel --add https://github.com/fission-codes/nix-overlay/archive/main.tar.gz fission`

You can then import `<fission>` in your code.

### Using Flakes 

If you're using flakes, set this repo as an input and add to `nixpkgs.overlays` like this:

```nix
inputs = {
  fission.url = "github:fission-codes/nix-overlay";
};

outputs = { self, nixpkgs, fission }: {
  nixosConfigurations.machine = nixpkgs.lib.nixosSystem {
    ...
    modules =
      [
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ fission.overlay ];
          ...
        })
      ];
  };
};

```