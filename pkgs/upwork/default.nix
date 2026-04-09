{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  makeWrapper,
  alsa-lib,
  libsecret,
  mesa,
  nss,
  nspr,
  libX11,
  libXcomposite,
  libxcursor,
  libxdamage,
  libxext,
  libxfixes,
  libxi,
  libxrandr,
  libxrender,
  libxtst,
  libxcb,
  libxscrnsaver,
  libuuid,
  at-spi2-atk,
  cups,
  dbus,
  expat,
  libdrm,
  libxkbcommon,
  gtk3,
  pango,
  cairo,
  gdk-pixbuf,
  glib,
}:

stdenv.mkDerivation rec {
  pname = "upwork";
  version = "5.8.0.35";

  src = fetchurl {
    url = "https://upwork-usw2-desktopapp.upwork.com/binaries/v${version}/upwork_${version}_amd64.deb";
    sha256 = "sha256-Suv23TL6l5HhkOSRT56LpFRZJxuSLYVc1uT6he8j7O0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    libsecret
    mesa
    nss
    nspr
    libX11
    libXcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxtst
    libxcb
    libxscrnsaver
    libuuid
    at-spi2-atk
    cups
    dbus
    expat
    libdrm
    libxkbcommon
    gtk3
    pango
    cairo
    gdk-pixbuf
    glib
  ];

  unpackPhase = ''
    dpkg-deb --extract $src .
  '';

  installPhase = ''
    mkdir -p $out/opt/Upwork $out/bin $out/share/applications $out/share/icons

    cp -r opt/Upwork/* $out/opt/Upwork/
    cp -r usr/share/icons/hicolor $out/share/icons/

    chmod +x $out/opt/Upwork/upwork
    chmod +x $out/opt/Upwork/chrome-sandbox || true
    chmod +x $out/opt/Upwork/chrome_crashpad_handler || true

    makeWrapper $out/opt/Upwork/upwork $out/bin/upwork \
      --add-flags "--no-sandbox"

    cat > $out/share/applications/upwork.desktop <<EOF
    [Desktop Entry]
    Name=Upwork
    Exec=$out/bin/upwork %U
    Terminal=false
    Type=Application
    Icon=upwork
    StartupWMClass=Upwork
    StartupNotify=false
    MimeType=x-scheme-handler/upwork;
    Comment=Upwork Desktop Application
    Categories=Utility;
    EOF
  '';

  meta = {
    description = "Upwork desktop application";
    homepage = "https://www.upwork.com";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "upwork";
  };
}
