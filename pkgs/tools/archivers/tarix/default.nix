{ pkgs
, fetchurl
, stdenv
, zlib
}:

stdenv.mkDerivation rec {
  version = "1.0.7";
  name = "tarix-${version}";

  src = fetchurl {
    url = "https://fastcat.org/software/tarix/tarix-${version}.tar.gz";
    sha256 = "1kwd4w9lz3gpl1lfz7pa82pcmq39hh7rv6kmg0mxik7vzalykyjv";
  };

  buildPhase = ''
     make bin/tarix CFLAGS="$CFLAGS -w"
  '';

  installPhase = ''
    mkdir -p $out/bin
    install bin/tarix $out/bin/
  '';

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ zlib ];

  meta = with stdenv.lib; {
    description = "A simple tar indexer for *nix. The tape specific
    bits currently work on Linux and FreeBSD. Lightly maintained as of
    September 2013.";
    homepage = "https://fastcat.org/software/";
    license = licenses.gpl2;
    maintainers = with maintainers; [ dysinger ];
    platforms = platforms.linux;
  };
}
