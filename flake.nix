{
  description = "Fission tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    fission.url = "github:fission-codes/fission/walkah/haskell-nix";
  };

  outputs = { self, nixpkgs, flake-utils, fission, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        overlay = final: _prev: import ../pkgs { inherit fission system; pkgs = final; };

        packages = import ./pkgs {
          inherit fission pkgs system;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ jq ];
        };
      }
    );
}
