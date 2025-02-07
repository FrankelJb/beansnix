{ lib
, host ? null
, ...
}:
let
  inherit (lib) types;
  inherit (lib.internal) mkOpt;
in
{
  options.beansnix.host = {
    name = mkOpt (types.nullOr types.str) host "The host name.";
  };
}
