{ pkgs, fission, system, ... }: {
  carmirror = pkgs.callPackage ./carmirror/default.nix { };
  kubo_carmirror = pkgs.callPackage ./carmirror/kubo.nix { };

  fission-cli = fission.packages.${system}.fission-cli;
  fission-server = fission.packages.${system}.fission-server;
}
