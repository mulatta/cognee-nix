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
    in
    {
      packages = {
        inherit
          cognee
          fastapi-users
          fastapi-users-db-sqlalchemy
          ;
      };
    };
}
