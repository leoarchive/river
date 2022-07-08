with builtins;

# let 
#   main = import ./../src/main.nix;
# in
#   (elemAt (import (elemAt main.apps 0)) 0).path

let 
  request = import ./default/http/url;
  file = fetchurl "https://nixos.wiki/wiki/Nix_by_example";
in
  (request "GET http://localhost:8080/todos/?limit=10&offset=2&")