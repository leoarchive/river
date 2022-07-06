
with import <nixpkgs> {};
with builtins;

let 
  request = "GET /articles?include=author HTTP/1.1";
  chars   = pkgs.lib.strings.stringToCharacters request;
  # method 0
  method  = index:
    let   char  =   elemAt chars index; in
    if    char  ==  " " || index >= stringLength request then ""
    else  char  +   method (index + 1);
  # path (stringLength (method 0) + 1)
  path    = index:
    let   char  =   elemAt chars index; in
    if    char  ==  "?" || index >= stringLength request then ""
    else  char  +   path (index + 1);

in
  "METHOD: " + method 0 + " PATH: " + path (stringLength (method 0) + 1)