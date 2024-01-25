{ pkgs, fission, system, ... }: {
  homestar = pkgs.callPackage ./homestar.nix { };
  fission-cli = fission.packages.${system}.fission-cli;
  fission-server = fission.packages.${system}.fission-server;
}
