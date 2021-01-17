{ fetchurl,
  godotBin
}:
godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-headless-bin";
  version = "3.2.3";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_linux_headless.64.zip";
    sha256 = "0flrxi7ri3503h8l5hl55qz7qjwfxkfdr1jc36lbicdfqr9nrw30";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}-stable_linux_headless.64 $out/bin/godot-headless
  '';
})
