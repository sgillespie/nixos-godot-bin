{ fetchurl,
  godotBin
}:

let
  majorVersion = "3.3";
  preVersion = "rc6";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-headless-bin";
  version = "${majorVersion}-${preVersion}";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${majorVersion}/${preVersion}/Godot_v${version}_linux_headless.64.zip";
    sha256 = "0jp165lrwci1655hd606lqyr0bb4blgx57pl7p9bawp1qsspwpkz";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}_linux_headless.64 $out/bin/godot-headless
  '';
})
