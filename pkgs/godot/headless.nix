{ fetchurl,
  godotBin
}:

let
  qualifier = "stable";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-headless-bin";
  version = "3.3.2";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/Godot_v${version}-${qualifier}_linux_headless.64.zip";
    sha256 = "0i4g7329929jf4zyrivxnh6p17vygjj6hb2f5vjc4xzdpsn68ydk";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}-${qualifier}_linux_headless.64 $out/bin/godot-headless
  '';
})
