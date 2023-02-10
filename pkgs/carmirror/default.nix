{ pkgs, buildGoModule, fetchFromGitHub, ... }:
let
  version = "0.1.0";
in
buildGoModule {
  name = "carmirror";
  version = version;

  src = fetchFromGitHub {
    owner = "fission-codes";
    repo = "kubo-car-mirror";
    rev = "b80ad74e8a5d7f23794e32d96ceab391260f917f";
    sha256 = "sha256-Mex3nrM04s5X61UxmRRT7JGw/w09/8xW7pwX+IOGtiA=";
  };

  vendorSha256 = "sha256-sBJ2za2jVtMd1ct3o54CbuHP++gdvkqnSF5h6aay8iE=";

  subPackages = [ "cmd/carmirror" ];
}

