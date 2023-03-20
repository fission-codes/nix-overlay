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
    rev = "b8d30df89fa7f00f2dd861a8f7481f9ed4c017d0";
    sha256 = "sha256-qZPaFfyYEaaVjVHRYhN7DPK6ZK2s5wmpqwEqDZXPYdU=";
  };

  vendorSha256 = "sha256-mN6urTjIdgwLp8/U7jc2VLhpFV/6ngu93rh0JJBuLaA=";

  subPackages = [ "cmd/carmirror" ];
}

