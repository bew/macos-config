{
  lib,
  stdenvNoCC,
  fetchurl,
  xar,
  cpio,
}:

# NOTE: MiddleDrag uses Apple's private MultitouchSupport framework to intercept raw touch data
# *before* the system gesture recognizer processes it.
# 👉 For this reason it cannot be built from source using Nix's xcodebuild.
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "middledrag";
  version = "1.4.3";

  src = fetchurl {
    name = "MiddleDrag-${finalAttrs.version}.pkg";
    url = "https://github.com/NullPointerDepressiveDisorder/MiddleDrag/releases/download/v${finalAttrs.version}/MiddleDrag-${finalAttrs.version}.pkg";
    hash = "sha256-CZb18sU0RvTsaJ9BSThJeJv/Gr/06jhkdJ9Gt/pqyZ4=";
  };

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  nativeBuildInputs = [ xar cpio ];

  unpackPhase = ''
    runHook preUnpack

    xar -xf "$src"
    cat Payload | gunzip -dc | cpio -i 2>/dev/null

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -R Applications/MiddleDrag.app $out/Applications/

    runHook postInstall
  '';

  meta = {
    description = "Three-finger trackpad gestures for middle-click and middle-drag on macOS";
    homepage = "https://middledrag.app/";
    license = lib.licenses.mit;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ bew ];
    platforms = lib.platforms.darwin;
  };
})
