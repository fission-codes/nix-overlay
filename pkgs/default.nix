{ pkgs, fission, system, ... }: {
  fission-server = pkgs.callPackage ./fission-server.nix { };
  homestar = pkgs.callPackage ./homestar.nix { };

  fission-cli = fission.packages.${system}.fission-cli;
  web-api = fission.packages.${system}.fission-server;
}
