{
  description = "Fission tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    fission.url = "github:fission-codes/fission/walkah/haskell-nix";
  };

  outputs = { nixpkgs, flake-utils, fission, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages = import ./pkgs {
            inherit fission pkgs system;
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [ jq ];
          };
        }
      ) // {
      overlay = final: _prev: import ./pkgs { inherit fission; system = final.system; pkgs = final; };
    };
}
