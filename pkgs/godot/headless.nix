{ fetchurl,
  godotBin
}:
godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-headless-bin";
  version = "3.2.4-beta6";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/3.2.4/beta6/Godot_v3.2.4-beta6_linux_headless.64.zip";
    sha256 = "0bbm6xi210m8bpfxyf9jjmgiag9s3dgi8an94z9fg58rghwhxfk1";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}_linux_headless.64 $out/bin/godot-headless
  '';
})
