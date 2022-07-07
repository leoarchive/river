
with import <nixpkgs> {};
with builtins;

let
  chars   = request: pkgs.lib.strings.stringToCharacters request;

  method  = chars: index:
    let   char  =   elemAt chars index; in
    if    char  ==  " " || index >= length chars then ""
    else  char  +   method chars (index + 1);

  path    = chars: index: 
    let   char  =   elemAt chars index; in
    if    char  ==  "?" || index >= length chars then ""
    else  char  +   path chars (index + 1);
    
  http    = request: 
  { 
    method = (method (chars request) 0); 
    path = (path (chars request) (stringLength (method (chars request) 0) + 1)); 
  };
in
  http