{ writeShellApplication
, pkgs
, lib
, ...
}:
writeShellApplication
{
  name = "trace-which";

  meta = {
    mainProgram = "trace-which";
  };

  checkPhase = "";

  text = ''
    a=$(which "$1") && exec ${lib.getExe pkgs.beansnix.trace-symlink} "$a"
  '';
}
