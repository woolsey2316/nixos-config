{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  makeWrapper,
  wrapGAppsHook3,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  libdrm,
  libgbm,
  libglvnd,
  libnotify,
  libpulseaudio,
  libsecret,
  libuuid,
  libx11,
  libxcb,
  libxcomposite,
  libxcursor,
  libxdamage,
  libxext,
  libxfixes,
  libxi,
  libxkbcommon,
  libxrandr,
  libxrender,
  libxscrnsaver,
  libxtst,
  nspr,
  nss,
  openssl,
  pango,
  systemd,
}:

stdenv.mkDerivation rec {
  pname = "upwork";
  version = "5.8.0.41";
  # Upwork CDN embeds this build id in the path; bump with version.
  hashVer = "f0de03505cc349f2";

  src = fetchurl {
    url = "https://upwork-usw2-desktopapp.upwork.com/binaries/v${
      builtins.replaceStrings [ "." ] [ "_" ] version
    }_${hashVer}/upwork_${version}_amd64.deb";
    hash = "sha256-su0f80z8wJz6n/Ry45RDqpmd13OGeleu9vUHmPslcjk=";
    # CDN WAF rejects plain curl; mimic Upwork's own updater client.
    curlOptsList = [
      "-H"
      "sec-fetch-site: none"
      "-H"
      "sec-fetch-mode: no-cors"
      "-H"
      "sec-fetch-dest: empty"
      "-H"
      "user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Upwork/5.8.0 Chrome/100.0.4896.160 Electron/18.3.15 Safari/537.36"
      "-H"
      "accept-encoding: gzip, deflate, br"
      "-H"
      "accept-language: en-US"
    ];
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libgbm
    libglvnd
    libnotify
    libpulseaudio
    libsecret
    libuuid
    libx11
    libxcb
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxkbcommon
    libxrandr
    libxrender
    libxscrnsaver
    libxtst
    nspr
    nss
    openssl
    pango
    stdenv.cc.cc
    systemd
  ];

  libPath = lib.makeLibraryPath buildInputs;

  dontWrapGApps = true;

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb --extract $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt $out/bin $out/share $out/lib/upwork
    cp -r opt/Upwork $out/opt/
    cp -r usr/share/* $out/share/

    # Electron expects OpenSSL 1.0 sonames (same approach as nixpkgs/spotify).
    ln -s ${lib.getLib openssl}/lib/libssl.so $out/lib/upwork/libssl.so.1.0.0
    ln -s ${lib.getLib openssl}/lib/libcrypto.so $out/lib/upwork/libcrypto.so.1.0.0

    chmod +x $out/opt/Upwork/upwork
    chmod +x $out/opt/Upwork/chrome-sandbox || true
    chmod +x $out/opt/Upwork/chrome_crashpad_handler || true

    sed -e "s|/opt/Upwork|$out/bin|g" -i $out/share/applications/upwork.desktop

    makeWrapper $out/opt/Upwork/upwork $out/bin/upwork \
      "''${gappsWrapperArgs[@]}" \
      --prefix LD_LIBRARY_PATH : "$out/lib/upwork:${libPath}" \
      --add-flags "--no-sandbox"

    runHook postInstall
  '';

  meta = {
    description = "Upwork desktop application";
    homepage = "https://www.upwork.com/ab/downloads/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "upwork";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
