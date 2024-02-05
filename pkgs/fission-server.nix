{ darwin, fetchFromGitHub, lib, pkgs, rustPlatform, stdenv }:

rustPlatform.buildRustPackage rec {
  pname = "fission-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "fission-codes";
    repo = pname;
    rev = "8985ae9c039e1d6c9c13a0c582aadbc258f6cba2";
    hash = "sha256-4A5KCZAj8hqEdPrsn2ZKQMsHy27TtoQMm4M2RMgAsNI=";
  };

  buildInputs = with pkgs; [ openssl postgresql ] ++ lib.optionals stdenv.isDarwin (
    with darwin.apple_sdk.frameworks; [
      CoreFoundation
      Security
      SystemConfiguration
    ]
  );
  nativeBuildInputs = with pkgs; [ pkg-config ];
  OPENSSL_NO_VENDOR = 1;

  cargoLock = {
    lockFile = src + "/Cargo.lock";
    outputHashes = {
      "rexpect-0.5.0" = "sha256-njjXt4pbLV3Z/ZkBzmBxcwDSqpbOttIpdg+kHND1vSo=";
      "rs-ucan-0.1.0" = "sha256-HSxIzqPECJ9KbPYU0aitjxpCf0CSDAv7su1PGxZlpHc=";
    };
  };

  doCheck = false;
}
