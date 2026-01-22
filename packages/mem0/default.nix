{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonRelaxDepsHook,
  # build system
  hatchling,
  # dependencies
  qdrant-client,
  pydantic,
  openai,
  posthog,
  pytz,
  sqlalchemy,
  protobuf,
}:
buildPythonPackage rec {
  pname = "mem0ai";
  version = "1.0.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mem0ai";
    repo = "mem0";
    rev = "v${version}";
    hash = "sha256-wvIPmqYlpto+ggifdSOjveEmSneKeZcoltItusYSu4Q=";
  };

  build-system = [ hatchling ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];

  pythonRelaxDeps = [
    "protobuf"
    "openai"
  ];

  dependencies = [
    qdrant-client
    pydantic
    openai
    posthog
    pytz
    sqlalchemy
    protobuf
  ];

  # Tests require external services (Qdrant, etc.)
  doCheck = false;

  # Import check disabled: mem0 tries to create ~/.mem0 directory at import time
  # which fails in the Nix sandbox (read-only filesystem)
  # pythonImportsCheck = [ "mem0" ];

  meta = {
    description = "The Memory layer for your AI apps";
    longDescription = ''
      Mem0 provides a smart, self-improving memory layer for Large Language
      Models, enabling personalized AI experiences across applications.

      IMPORTANT: mem0 creates a config directory at import time. Set the
      MEM0_DIR environment variable to a writable location before importing:

        export MEM0_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/mem0"

      Without this, mem0 will attempt to write to ~/.mem0 which may fail
      in read-only environments.
    '';
    homepage = "https://github.com/mem0ai/mem0";
    changelog = "https://github.com/mem0ai/mem0/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
}
