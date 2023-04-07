{ pkgs, buildGo119Module, fetchFromGitHub, nixosTests, ... }:
let
  version = "0.19.1-carmirror";
in
buildGo119Module {
  pname = "kubo";
  version = version;

  passthru.repoVersion = "13"; # Also update kubo-migrator when changing the repo version

  src = fetchFromGitHub {
    owner = "fission-codes";
    repo = "kubo";
    rev = "f40ed2f9b9947d5d10d22ab046586ecdcf8841ca";
    sha256 = "sha256-Tzzv5x19mgXsvk7ja/0N9jUx8wCY43RSak9sbwnk4uQ=";
  };

  subPackages = [ "cmd/ipfs" ];

  buildInputs = [ pkgs.openssl ];
  nativeBuildInputs = [ pkgs.pkg-config ];
  tags = [ "openssl" ];

  passthru.tests.kubo = nixosTests.kubo;

  vendorSha256 = "sha256-1gMP7OyoqV1BPRmafhazyC0ly0/J0Y/WZuLCrNudhz0=";

  outputs = [ "out" "systemd_unit" "systemd_unit_hardened" ];

  postPatch = ''
    substituteInPlace 'misc/systemd/ipfs.service' \
      --replace '/usr/bin/ipfs' "$out/bin/ipfs"
    substituteInPlace 'misc/systemd/ipfs-hardened.service' \
      --replace '/usr/bin/ipfs' "$out/bin/ipfs"
  '';

  postInstall = ''
    install --mode=444 -D 'misc/systemd/ipfs-api.socket' "$systemd_unit/etc/systemd/system/ipfs-api.socket"
    install --mode=444 -D 'misc/systemd/ipfs-gateway.socket' "$systemd_unit/etc/systemd/system/ipfs-gateway.socket"
    install --mode=444 -D 'misc/systemd/ipfs.service' "$systemd_unit/etc/systemd/system/ipfs.service"

    install --mode=444 -D 'misc/systemd/ipfs-api.socket' "$systemd_unit_hardened/etc/systemd/system/ipfs-api.socket"
    install --mode=444 -D 'misc/systemd/ipfs-gateway.socket' "$systemd_unit_hardened/etc/systemd/system/ipfs-gateway.socket"
    install --mode=444 -D 'misc/systemd/ipfs-hardened.service' "$systemd_unit_hardened/etc/systemd/system/ipfs.service"
  '';
}
