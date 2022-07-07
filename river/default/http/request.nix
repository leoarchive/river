
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
    
  request = req: 
  { 
    method  = (method (chars req) 0); 
    path    = (path (chars req) (stringLength (method (chars req) 0) + 1)); 
  };
in
  request