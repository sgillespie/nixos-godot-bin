{ stdenv,
  lib,
  autoPatchelfHook,
  fetchurl,
  unzip,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
}:

stdenv.mkDerivation rec {
  pname = "godot-bin";
  version = "3.2.3";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip";
    sha256 = "1ypp4kpz3cs6238px0sc5jnwhk0r3g6p3wqjaqm3a549fr8m1idj";
  };

  nativeBuildInputs = [autoPatchelfHook unzip];

  buildInputs = [
    alsaLib
    libXcursor
    libXinerama
    libXrandr
    libXrender
    libX11
    libXi
    libpulseaudio
    libGL
  ];

  unpackCmd = "unzip $curSrc -d source";
  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}-stable_x11.64 $out/bin/godot
  '';

  meta = {
    homepage    = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license     = stdenv.lib.licenses.mit;
    platforms   = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ stdenv.lib.maintainers.twey ];
  };
}
