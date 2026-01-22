{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  # build system
  hatchling,
  hatch-regex-commit,
  # dependencies
  fastapi-users,
  sqlalchemy,
  # test dependencies
  pytestCheckHook,
  pytest-asyncio,
  aiosqlite,
}:
buildPythonPackage rec {
  pname = "fastapi-users-db-sqlalchemy";
  version = "7.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "fastapi-users";
    repo = "fastapi-users-db-sqlalchemy";
    rev = "v${version}";
    hash = "sha256-VP//iYzyflqzCn/SkgeoSN+DjirLBWuH9yDJwtcCXCA=";
  };

  build-system = [
    hatchling
    hatch-regex-commit
  ];

  dependencies = [
    fastapi-users
    sqlalchemy
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-asyncio
    aiosqlite
  ];

  pythonImportsCheck = [ "fastapi_users_db_sqlalchemy" ];

  meta = {
    description = "FastAPI Users database adapter for SQLAlchemy";
    homepage = "https://github.com/fastapi-users/fastapi-users-db-sqlalchemy";
    changelog = "https://github.com/fastapi-users/fastapi-users-db-sqlalchemy/releases/tag/v${version}";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
