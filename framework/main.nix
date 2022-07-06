with builtins;

# let 
#   main = import ./../src/main.nix;
# in
#   (elemAt (import (elemAt main.apps 0)) 0).path

let 
  getRequest = import ./http/request.nix;
  file = fetchurl "https://nixos.wiki/wiki/Nix_by_example";
in
  getRequest