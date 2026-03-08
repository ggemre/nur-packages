{
  callPackage,
  lib,
  stdenv,
  fetchFromGitLab,
  fetchpatch,
  meson,
  ninja,
  pkg-config,
  wayland-scanner,
  libGL,
  wayland,
  # wayland-protocols,
  libinput,
  libxkbcommon,
  pixman,
  libcap,
  libgbm,
  libxcb-wm,
  libxcb-render-util,
  libxcb-image,
  libxcb-errors,
  libx11,
  hwdata,
  seatd,
  vulkan-loader,
  glslang,
  libliftoff,
  libdisplay-info,
  lcms2,
  nixosTests,
  testers,
  enableXWayland ? true,
  xwayland ? null,
}: let
  wayland-protocols = callPackage ./wayland-protocols.nix {};
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "wlroots";
    version = "0.20.0-rc3";

    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "wlroots";
      repo = "wlroots";
      rev = finalAttrs.version;
      hash = "sha256-qUhb/hDw4v28wwB/TTKIN0TJvuBCayXBKFbXMzGd7Cs=";
    };

    outputs = [
      "out"
      "examples"
    ];

    strictDeps = true;
    depsBuildBuild = [pkg-config];

    nativeBuildInputs = [
      lcms2
      meson
      ninja
      pkg-config
      wayland-scanner
      glslang
      hwdata
    ];

    propagatedBuildInputs = [
      # The headers of wlroots #include <libinput.h>, and consumers of `wlroots` need not add it explicitly, hence we propagate it.
      libinput
    ];

    buildInputs =
      [
        libliftoff
        libdisplay-info
        libGL
        libcap
        libxkbcommon
        libgbm
        pixman
        seatd
        vulkan-loader
        wayland
        wayland-protocols
        lcms2
        libx11
        libxcb-errors
        libxcb-image
        libxcb-render-util
        libxcb-wm
      ]
      ++ lib.optional enableXWayland xwayland;

    mesonFlags = lib.optional (!enableXWayland) "-Dxwayland=disabled";

    postFixup = ''
      # Install ALL example programs to $examples:
      # screencopy dmabuf-capture input-inhibitor layer-shell idle-inhibit idle
      # screenshot output-layout multi-pointer rotation tablet touch pointer
      # simple
      mkdir -p $examples/bin
      cd ./examples
      for binary in $(find . -executable -type f -printf '%P\n' | grep -vE '\.so'); do
        cp "$binary" "$examples/bin/wlroots-$binary"
      done
    '';

    meta = {
      description = "Modular Wayland compositor library";
      longDescription = ''
        Pluggable, composable, unopinionated modules for building a Wayland
        compositor; or about 50,000 lines of code you were going to write anyway.
      '';
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
    };
  })
