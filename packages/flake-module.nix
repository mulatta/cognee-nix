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
      mem0 = pythonPackages.callPackage ./mem0 { };
      cognee = pythonPackages.callPackage ./cognee {
        inherit fastapi-users-db-sqlalchemy mem0;
      };
    in
    {
      packages = {
        inherit
          cognee
          fastapi-users
          fastapi-users-db-sqlalchemy
          mem0
          ;
      };
    };
}
