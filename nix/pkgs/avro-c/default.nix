{ lib, stdenv, cmake, fetchurl, pkg-config, jansson, lzma, snappy, zlib }:

stdenv.mkDerivation rec {
  pname = "avro-c";
  version = "1.11.0";

  src = fetchurl {
    url = "mirror://apache/avro/avro-${version}/c/avro-c-${version}.tar.gz";
    sha256 = "sha256-BlJZClStjkqliiuf8fTOcaZKQbCgXEUp0cUYxh52BkM=";
  };

  postPatch = ''
    sed -i 's|set(CODEC_PKG "@ZLIB_PKG@ @LZMA_PKG@ @SNAPPY_PKG@")|set(CODEC_PKG "''${ZLIB_PKG} ''${LZMA_PKG} snappy")|g' ./CMakeLists.txt
    patchShebangs .
  '';

  nativeBuildInputs = [ pkg-config cmake ];

  buildInputs = [ jansson lzma snappy zlib ];

  meta = with lib; {
    description = "A C library which implements parts of the Avro Specification";
    homepage = "https://avro.apache.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ lblasc ];
    platforms = platforms.all;
  };
}
