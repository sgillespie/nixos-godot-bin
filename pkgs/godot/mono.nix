{ fetchurl,
  godotBin,
  msbuild,
  dotnetPackages,
  mono5,
  zlib
}:

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-mono-bin";
  version = "3.2.4-beta6";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/3.2.4/beta6/mono/Godot_v3.2.4-beta6_mono_x11_64.zip";
    sha256 = "1ql58irqkjppn0kb91155nb6sbspv5hf9qgi6hfbgxz42iiyv8ic";
  };

  buildInputs = oldAttrs.buildInputs ++ [zlib];

  unpackCmd = "";
  installPhase = ''
    mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${version}_mono_x11.64 $out/opt/godot-mono/Godot_v${version}_mono_x11.64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${version}_mono_x11.64 $out/bin/godot-mono
  '';
})
