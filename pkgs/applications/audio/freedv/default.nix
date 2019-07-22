{ pkgs
, stdenv
, fetchsvn
, cmake
, codec2
, hamlib
, libsamplerate
, libsndfile
, portaudio
, speex
, wxGTK31
}:

let

  rev_str = "4121";
  rev_int = (stdenv.lib.strings.toInt rev_str);

  codec2dev = codec2.overrideAttrs (oldAttrs: rec {
    name = "codec2-${rev_str}";
    src = fetchsvn {
      rev = rev_int;
      sha256 = "17bs776qndlk5hwy60imcryvqxhhncl0ij0326q8gh3lr0ha8q6s";
      url = svn://svn.code.sf.net/p/freetel/code/codec2-dev;
    };
  });

in

stdenv.mkDerivation rec {
  version = rev_str;
  name = "freedv-${rev_str}";

  src = fetchsvn {
    name = name;
    rev = rev_int;
    sha256 = "0kykqb9ici1jclzfjd20psrm381lmjcwfa0fwm1kxapg70plhlm1";
    url = svn://svn.code.sf.net/p/freetel/code/freedv-dev;
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [
    codec2dev
    hamlib
    libsamplerate
    libsndfile
    portaudio
    speex
    wxGTK31
  ];

  cmakeFlags = [ "-DUSE_STATIC_CODEC2=False" ];

  meta = with stdenv.lib; {
    description = "Freedv digital voice modem for ham radio.";
    homepage = "https://freedv.org/";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ dysinger ];
    platforms = platforms.linux;
  };
}
