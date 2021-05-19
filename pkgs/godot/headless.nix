{ fetchurl,
  godotBin
}:

let
  qualifier = "stable";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-headless-bin";
  version = "3.3.1";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/Godot_v${version}-${qualifier}_linux_headless.64.zip";
    sha256 = "1qz71nr72a83dq82jm5pnbj5rkg0w23hqazms59d175xm77m1bkk";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}-${qualifier}_linux_headless.64 $out/bin/godot-headless
  '';
})
