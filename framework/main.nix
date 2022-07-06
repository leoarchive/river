with builtins;

let 
  main = import ./../src/main.nix;
in
  (elemAt (import (elemAt main.apps 0)) 0).module.read