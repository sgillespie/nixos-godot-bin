{ stdenv,
  lib,
  autoPatchelfHook,
  fetchurl,
  unzip,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
}:

let
  qualifier = "stable";
in

stdenv.mkDerivation rec {
  pname = "godot-bin";
  version = "3.3.2";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/Godot_v${version}-${qualifier}_x11.64.zip";
    sha256 = "0sracw2b9ymjg3ypng3020fy8m0hpp7fhzmni89f73k4mssib020";
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
    install -m 0755 Godot_v${version}-${qualifier}_x11.64 $out/bin/godot
  '';

  meta = {
    homepage    = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license     = lib.licenses.mit;
    platforms   = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ lib.maintainers.twey ];
  };
}
