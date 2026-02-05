# Cognee Frontend - Next.js web UI
#
# Uses bun to fetch all platform deps (--cpu="*" --os="*")
# This avoids HTTP/2 issues in prefetch-npm-deps and supports all platforms with single hash
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  bun,
  nodejs_22,
  makeWrapper,
  inter,
}:
let
  nodejs = nodejs_22;
  sourceRoot = "source/cognee-frontend";
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cognee-frontend";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "topoteretes";
    repo = "cognee";
    tag = "v${finalAttrs.version}";
    hash = "sha256-4s3DOvHsAHHoyivwcMX7JJNzNzueAE/qdrdd1w6HGkc=";
  };

  inherit sourceRoot;

  # Fetch all platform deps using bun (FOD)
  node_modules = stdenvNoCC.mkDerivation {
    pname = "${finalAttrs.pname}-node_modules";
    inherit (finalAttrs) version src sourceRoot;

    nativeBuildInputs = [ bun ];

    dontConfigure = true;

    buildPhase = ''
      runHook preBuild
      export HOME=$TMPDIR
      bun install \
        --cpu="*" \
        --os="*" \
        --frozen-lockfile \
        --ignore-scripts \
        --no-progress
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r node_modules $out/
      runHook postInstall
    '';

    dontFixup = true;

    outputHash = "sha256-xvvzmNmNnG7VAz1IDlPUNnbVpzG9JbJnJn82sI33k/M=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };

  nativeBuildInputs = [
    nodejs
    makeWrapper
  ];

  configurePhase = ''
    runHook preConfigure
    cp -r ${finalAttrs.node_modules}/node_modules .
    chmod -R u+w node_modules
    patchShebangs node_modules

    # Use local Inter font from nixpkgs instead of Google Fonts
    # Google Fonts require network access which is not available in Nix sandbox
    mkdir -p src/app/fonts
    cp ${inter}/share/fonts/truetype/InterVariable.ttf src/app/fonts/

    substituteInPlace src/app/layout.tsx \
      --replace-fail 'import { Inter } from "next/font/google";' 'import localFont from "next/font/local";' \
      --replace-fail 'const inter = Inter({ subsets: ["latin"] });' 'const inter = localFont({ src: "./fonts/InterVariable.ttf", variable: "--font-inter" });'

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    export HOME=$TMPDIR
    export NEXT_TELEMETRY_DISABLED=1
    npm run build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/cognee-frontend

    cp -r .next $out/share/cognee-frontend/
    cp -r node_modules $out/share/cognee-frontend/
    cp -r public $out/share/cognee-frontend/
    cp package.json $out/share/cognee-frontend/

    # Remove build-time only SWC binaries to reduce closure size (~1GB)
    rm -rf $out/share/cognee-frontend/node_modules/@next/swc-*

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/cognee-frontend \
      --chdir "$out/share/cognee-frontend" \
      --set NODE_ENV production \
      --set PORT 3000 \
      --add-flags "$out/share/cognee-frontend/node_modules/.bin/next" \
      --add-flags "start"

    runHook postInstall
  '';

  meta = {
    description = "Next.js web UI for Cognee knowledge management";
    homepage = "https://github.com/topoteretes/cognee/tree/main/cognee-frontend";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ mulatta ];
    mainProgram = "cognee-frontend";
    platforms = lib.platforms.all;
  };
})
