{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "claw";
  version = "latest";

  src = ./claw-code/rust;

  cargoLock = {
    lockFile = ./claw-code/rust/Cargo.lock;
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    openssl
  ];

  doCheck = false;
}
