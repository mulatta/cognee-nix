{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonRelaxDepsHook,
  # build system
  hatchling,
  # dependencies
  openai,
  python-dotenv,
  pydantic,
  pydantic-settings,
  typing-extensions,
  numpy,
  sqlalchemy,
  aiosqlite,
  tiktoken,
  litellm,
  instructor,
  filetype,
  aiohttp,
  aiofiles,
  rdflib,
  pypdf,
  jinja2,
  lancedb,
  nbformat,
  alembic,
  limits,
  fastapi,
  python-multipart,
  fastapi-users-db-sqlalchemy,
  structlog,
  pympler,
  onnxruntime,
  pylance,
  kuzu,
  fastembed,
  networkx,
  uvicorn,
  gunicorn,
  websockets,
  mistralai,
  tenacity,
  fakeredis,
  diskcache,
  aiolimiter,
  mem0,
}:
buildPythonPackage rec {
  pname = "cognee";
  version = "0.5.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "topoteretes";
    repo = "cognee";
    rev = "v${version}";
    hash = "sha256-4s3DOvHsAHHoyivwcMX7JJNzNzueAE/qdrdd1w6HGkc=";
  };

  build-system = [ hatchling ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];

  pythonRelaxDeps = [
    "fastembed"
    "fastapi-users"
    "kuzu"
    "limits"
    "onnxruntime"
    "pydantic"
    "pylance"
    "rdflib"
  ];

  dependencies = [
    openai
    python-dotenv
    pydantic
    pydantic-settings
    typing-extensions
    numpy
    sqlalchemy
    aiosqlite
    tiktoken
    litellm
    instructor
    filetype
    aiohttp
    aiofiles
    rdflib
    pypdf
    jinja2
    lancedb
    nbformat
    alembic
    limits
    fastapi
    python-multipart
    fastapi-users-db-sqlalchemy
    structlog
    pympler
    onnxruntime
    pylance
    kuzu
    fastembed
    networkx
    uvicorn
    gunicorn
    websockets
    mistralai
    tenacity
    fakeredis
    diskcache
    aiolimiter
    mem0
  ];

  # Tests require external services
  doCheck = false;

  pythonImportsCheck = [ "cognee" ];

  meta = {
    description = "Memory management for AI applications and AI agents";
    homepage = "https://github.com/topoteretes/cognee";
    changelog = "https://github.com/topoteretes/cognee/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
}
