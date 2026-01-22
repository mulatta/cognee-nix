{
  perSystem =
    { config, pkgs, ... }:
    let
      python = pkgs.python313;
      pythonWithCognee = python.withPackages (_: [ config.packages.cognee ]);
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          config.treefmt.build.wrapper
          pkgs.jujutsu
          pkgs.nix-prefetch-github
          pythonWithCognee
        ];

        shellHook = ''
          export SYSTEM_ROOT_DIRECTORY="$PWD/.cognee_system"
          export DATA_ROOT_DIRECTORY="$PWD/.cognee_data"
        '';
      };
    };
}
