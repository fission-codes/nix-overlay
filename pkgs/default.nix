{ pkgs, ... }: {
  carmirror = pkgs.callPackage ./carmirror/default.nix { };
  kubo_carmirror = pkgs.callPackage ./carmirror/kubo.nix { };
}
