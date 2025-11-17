{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  libseccomp,
  python3,
  flock,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ceccomp";
  version = "3.5";

  src = fetchFromGitHub {
    owner = "dbgbgtf1";
    repo = "Ceccomp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-TVRYWRkrXlSgGXL2KtFsFx26ncf77QE+edZvv2HtVkg=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libseccomp
    python3
    flock
  ];

  configurePhase = ''
    runHook preConfigure

    python ./configure --without-doc --without-i18n --prefix=$out --packager=Nix

    runHook postConfigure
  '';

  enableParallelBuilding = true;

  meta = {
    description = "A tool to analyze seccomp filters like `seccomp-tools` but in C";
    homepage = "https://github.com/dbgbgtf1/Ceccomp";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ tesuji ];
    platforms = lib.platforms.linux;
    mainProgram = "ceccomp";
  };
})
