{ darwin, fetchFromGitHub, lib, rustPlatform, stdenv }:

rustPlatform.buildRustPackage rec {
  pname = "homestar";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "ipvm-wg";
    repo = pname;
    rev = "homestar-runtime-v${version}";
    hash = "sha256-5o2/ln2sunmfhN0DnGGdVvimjh76bKTnYERbjBib5VM=";
  };

  cargoHash = "sha256-S7rS3exeRzg2JPgZfVbgmQgaXvywA8kzutIMpbxeYvA=";

  buildInputs = lib.optionals stdenv.isDarwin (
    with darwin.apple_sdk.frameworks; [
      Security
      SystemConfiguration
    ]
  );

  doCheck = false;
}
