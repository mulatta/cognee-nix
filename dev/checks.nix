{
  perSystem =
    { config, lib, ... }:
    {
      checks = lib.mapAttrs' (name: pkg: lib.nameValuePair "package-${name}" pkg) config.packages;
    };
}
