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
  # optional dependencies
  neo4j ? null,
  chromadb ? null,
  pypika ? null,
  psycopg2 ? null,
  pgvector ? null,
  asyncpg ? null,
  protego ? null,
  playwright ? null,
  beautifulsoup4 ? null,
  lxml ? null,
  # feature flags
  withNeo4j ? false,
  withChromadb ? false,
  withPostgres ? false,
  withScraping ? false,
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
  ]
  ++ lib.optionals withNeo4j [ neo4j ]
  ++ lib.optionals withChromadb [
    chromadb
    pypika
  ]
  ++ lib.optionals withPostgres [
    psycopg2
    pgvector
    asyncpg
  ]
  ++ lib.optionals withScraping [
    protego
    playwright
    beautifulsoup4
    lxml
  ];

  # Tests require external services
  doCheck = false;

  pythonImportsCheck = [ "cognee" ];

  passthru = {
    optional-dependencies = {
      neo4j = [ neo4j ];
      chromadb = [
        chromadb
        pypika
      ];
      postgres = [
        psycopg2
        pgvector
        asyncpg
      ];
      scraping = [
        protego
        playwright
        beautifulsoup4
        lxml
      ];
    };
  };

  meta = {
    description = "Memory management for AI applications and AI agents";
    longDescription = ''
      Cognee is a memory management system for AI applications and AI agents.

      Optional features can be enabled via override:
        cognee.override { withNeo4j = true; }
        cognee.override { withChromadb = true; }
        cognee.override { withPostgres = true; }
        cognee.override { withScraping = true; }

      Or access optional-dependencies directly:
        cognee.optional-dependencies.neo4j
        cognee.optional-dependencies.chromadb
        cognee.optional-dependencies.postgres
        cognee.optional-dependencies.scraping
    '';
    homepage = "https://github.com/topoteretes/cognee";
    changelog = "https://github.com/topoteretes/cognee/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
}
