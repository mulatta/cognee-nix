{
  flake.overlays.default = _final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (python-final: _python-prev: {
        fastapi-users = python-final.callPackage ../packages/fastapi-users { };
        fastapi-users-db-sqlalchemy = python-final.callPackage ../packages/fastapi-users-db-sqlalchemy { };
        cognee = python-final.callPackage ../packages/cognee { };
        cognee-mcp = python-final.callPackage ../packages/cognee-mcp { };
      })
    ];
  };
}
