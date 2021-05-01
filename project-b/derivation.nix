{ stdenv, cmake, test_a }:

stdenv.mkDerivation rec {
  pname = "test_b";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [cmake];

  buildInputs = [
    test_a
  ];
}
