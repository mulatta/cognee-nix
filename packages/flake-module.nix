{
  perSystem =
    { pkgs, ... }:
    let
      python = pkgs.python313;
      pythonPackages = python.pkgs;

      fastapi-users = pythonPackages.callPackage ./fastapi-users { };
      fastapi-users-db-sqlalchemy = pythonPackages.callPackage ./fastapi-users-db-sqlalchemy {
        inherit fastapi-users;
      };
      cognee = pythonPackages.callPackage ./cognee {
        inherit fastapi-users-db-sqlalchemy;
      };
      cognee-mcp = pythonPackages.callPackage ./cognee-mcp {
        inherit cognee;
      };
    in
    {
      packages = {
        inherit
          cognee
          cognee-mcp
          fastapi-users
          fastapi-users-db-sqlalchemy
          ;
      };
    };
}
