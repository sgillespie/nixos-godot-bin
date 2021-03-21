{ stdenv,
  lib,
  autoPatchelfHook,
  fetchurl,
  unzip,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
}:

let
  majorVersion = "3.3";
  preVersion = "rc6";
in

stdenv.mkDerivation rec {
  pname = "godot-bin";
  version = "${majorVersion}-${preVersion}";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${majorVersion}/${preVersion}/Godot_v${version}_x11.64.zip";
    sha256 = "1r7bybyww0ni9bs2ik3arrrl17fr4hdsrnlysa4w1xv4gfx393r4";
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
    install -m 0755 Godot_v${version}_x11.64 $out/bin/godot
  '';

  meta = {
    homepage    = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license     = lib.licenses.mit;
    platforms   = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ lib.maintainers.twey ];
  };
}
