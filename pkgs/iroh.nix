{ fetchFromGitHub, pkgs, rustPlatform, stdenv }:

rustPlatform.buildRustPackage
{
  pname = "iroh";
  version = "0.5.1";
  src = fetchFromGitHub {
    owner = "n0-computer";
    repo = "iroh";
    rev = "v0.5.1";
    hash = "sha256-p1OvXso5szo8ZCnCTKgDzCEMJgiePXQMhVYOkWVZrbE=";
  };

  cargoHash = "sha256-QqMBEYaIQ6PqO7w7Yd1jVr0zHARsVaJtZzWytmDksZQ=";

  buildInputs = with pkgs; [
    libiconv
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
    darwin.apple_sdk.frameworks.Security
  ];

  # Skip the netcheck test, which requires a network connection.
  checkFlags = [
    "--skip=netcheck::reportgen::probes::tests::test_plan_with_report"
  ];
}

