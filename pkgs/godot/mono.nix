{ fetchurl,
  godotBin,
  msbuild,
  dotnetPackages,
  mono5,
  zlib
}:

let
  qualifier = "stable";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-mono-bin";
  version = "3.3.1";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/mono/Godot_v${version}-${qualifier}_mono_x11_64.zip";
    sha256 = "0ypjdlinqb47a0zpi3n4n1l1h1c3byjq73rcwqk5q3izyczq000z";
  };

  buildInputs = oldAttrs.buildInputs ++ [zlib];

  unpackCmd = "";
  installPhase = ''
    mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${version}-${qualifier}_mono_x11.64 $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_x11.64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_x11.64 $out/bin/godot-mono
  '';
})
