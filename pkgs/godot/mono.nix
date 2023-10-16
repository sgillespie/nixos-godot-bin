{ fetchurl,
  godotBin,
  msbuild,
  dotnetPackages,
  mono5,
  zlib,
  godotDesktopFile,
  godotIconPNG,
  godotIconSVG,
  godotManpage
}:

let
  qualifier = "stable";
in

godotBin.overrideAttrs (oldAttrs: rec {
  pname = "godot-mono-bin";
  version = "3.5.1";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/mono/Godot_v${version}-${qualifier}_mono_x11_64.zip";
    sha256 = "7phG4vgq4m0h92gCMPv5kehQQ1BH7rS1c5VZ6Dx3WPc=";
  };

  buildInputs = oldAttrs.buildInputs ++ [zlib];

  unpackCmd = "";
  installPhase = ''
    mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${version}-${qualifier}_mono_x11.64 $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_x11.64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_x11.64 $out/bin/godot-mono

    # Only create a desktop file, if the necessary variables are set
    # these are set only, if one installs this program using flakes.
    if [[ -f "${godotDesktopFile}" ]]; then
      mkdir -p "$out/man/share/man/man6"
      cp ${godotManpage} "$out/man/share/man/man6/"

      mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
      cp ${godotDesktopFile} "$out/share/applications/org.godotengine.Godot-Mono.desktop"
      cp ${godotIconSVG} "$out/share/icons/hicolor/scalable/apps/godot.svg"
      cp ${godotIconPNG} "$out/share/icons/godot.png"
      substituteInPlace "$out/share/applications/org.godotengine.Godot-Mono.desktop" \
        --replace "Exec=godot" "Exec=$out/bin/godot-mono"
    fi
  '';

  postFixup = ''
    wrapProgram $out/bin/godot-mono \
      --set LD_LIBRARY_PATH ${oldAttrs.libraries}
  '';
})
