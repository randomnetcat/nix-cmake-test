{
  pkgs ? import <nixpkgs> {}
}:

pkgs.callPackage ./derivation.nix { test_a = pkgs.callPackage (import ../project-a/derivation.nix) { }; }
