{ fetchurl,
  godotBin,
  msbuild,
  dotnetPackages,
  mono5,
  zlib
}:

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-mono-bin";
  version = "3.2.3";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/3.2.3/mono/Godot_v3.2.3-stable_mono_x11_64.zip";
    sha256 = "0m11wclzynxf756vqralx5pj69z984znbcaxx81h51x25m05im2a";
  };

  buildInputs = oldAttrs.buildInputs ++ [zlib];

  unpackCmd = "";
  installPhase = ''
    mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${version}-stable_mono_x11.64 $out/opt/godot-mono/Godot_v${version}-stable_mono_x11.64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${version}-stable_mono_x11.64 $out/bin/godot-mono
  '';
})
