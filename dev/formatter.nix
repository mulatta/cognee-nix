{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          # Nix
          nixfmt.enable = true;
          deadnix.enable = true;

          # Keep sorted
          keep-sorted.enable = true;
        };

        settings.global.excludes = [
          "**/.direnv/**"
          "**/result/**"
        ];
      };
    };
}
