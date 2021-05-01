{ stdenv, cmake, fmt }:

stdenv.mkDerivation rec {
  pname = "test_a";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ cmake ];

  propagatedBuildInputs = [
    fmt
  ];
}
