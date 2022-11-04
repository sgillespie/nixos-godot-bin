{ fetchurl,
  godotBin
}:

let
  qualifier = "stable";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-headless-bin";
  version = "3.5.1";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/Godot_v${version}-${qualifier}_linux_headless.64.zip";
    sha256 = "NgrJetf/EPYW64pix/+8PRrna0QlvnsA2tbdqjpEFHY=";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}-${qualifier}_linux_headless.64 $out/bin/godot-headless
  '';

  postFixup = ''
    wrapProgram $out/bin/godot-headless \
      --set LD_LIBRARY_PATH ${oldAttrs.libraries}
  '';
})
