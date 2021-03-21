{ fetchurl,
  godotBin,
  msbuild,
  dotnetPackages,
  mono5,
  zlib
}:

let
  majorVersion = "3.3";
  preVersion = "rc6";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-mono-bin";
  version = "${majorVersion}-${preVersion}";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${majorVersion}/${preVersion}/mono/Godot_v${version}_mono_x11_64.zip";
    sha256 = "0bya0fnllxqxsisfpj1lfpxds0xb95dhsmw55822hc58nxqnf4in";
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
