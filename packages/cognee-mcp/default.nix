{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  hatchling,

  # dependencies
  cognee,
  fastmcp,
  httpx,
  mcp,
}:

buildPythonPackage {
  pname = "cognee-mcp";
  version = "0.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "topoteretes";
    repo = "cognee";
    tag = "v0.5.1";
    hash = "sha256-4s3DOvHsAHHoyivwcMX7JJNzNzueAE/qdrdd1w6HGkc=";
  };

  sourceRoot = "source/cognee-mcp";

  build-system = [ hatchling ];

  pythonRelaxDeps = [ "cognee" ];
  pythonRemoveDeps = [ "uv" ];

  dependencies = [
    cognee
    fastmcp
    httpx
    mcp
  ];

  # Tests require external services
  doCheck = false;

  pythonImportsCheck = [ "src" ];

  meta = {
    description = "Cognee MCP server";
    homepage = "https://github.com/topoteretes/cognee/tree/main/cognee-mcp";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ mulatta ];
  };
}
