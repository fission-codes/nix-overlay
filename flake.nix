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
    homestar.url = "github:ipvm-wg/homestar/homestar-runtime-v0.2.0";
    fission-server.url = "github:fission-codes/fission-server";
  };

  outputs = { self, nixpkgs, flake-utils, fission, homestar, fission-server, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages = {
            homestar = homestar.packages.${system}.default;
            fission-server = fission-server.packages.${system}.default;
            fission-cli = fission.packages.${system}.fission-cli;
            web-api = fission.packages.${system}.fission-server;
          };
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [ jq ];
          };
        }
      ) // {
      overlay = final: prev: {
        inherit (self.packages.${prev.system}) homestar fission-server fission-cli web-api;
      };
    };
}
