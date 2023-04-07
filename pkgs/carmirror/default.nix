{ pkgs, buildGo119Module, fetchFromGitHub, ... }:
let
  version = "0.1.0";
in
buildGo119Module {
  name = "carmirror";
  version = version;

  src = fetchFromGitHub {
    owner = "fission-codes";
    repo = "kubo-car-mirror";
    rev = "b0bce69e8db26d0aec27fa379a66f6f7149df282";
    sha256 = "sha256-BMl5IDw8kr4OQA117p4QA5p1gRKdpJBjzz40pCK4qNc=";
  };

  vendorSha256 = "sha256-VqmGQd8osA0EVcxeI4r71FeWeItOheGrvYDdbtwyck8=";

  subPackages = [ "cmd/carmirror" ];
}

