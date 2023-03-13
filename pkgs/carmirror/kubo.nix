{ pkgs, buildGoModule, fetchFromGitHub, nixosTests, ... }:
let
  version = "0.18.1";
in
buildGoModule {
  pname = "kubo";
  version = version;

  passthru.repoVersion = "13"; # Also update kubo-migrator when changing the repo version

  src = fetchFromGitHub {
    owner = "fission-codes";
    repo = "go-ipfs";
    rev = "1f68095bf1cacc9bdf89c0fb052087af3641ac0c";
    sha256 = "sha256-7C8rrW7QRqD6KmmM5hnyz1m9z+IWJZl/tHKzwPaZ2EM=";
  };

  subPackages = [ "cmd/ipfs" ];

  buildInputs = [ pkgs.openssl ];
  nativeBuildInputs = [ pkgs.pkg-config ];
  tags = [ "openssl" ];

  passthru.tests.kubo = nixosTests.kubo;

  vendorSha256 = "sha256-TLB7xdp7n1fqQ+O+rfSyxfLvHX/5q3uOJlsJKlQfc2U=";

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
