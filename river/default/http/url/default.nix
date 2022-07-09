
with import <nixpkgs> {};
with builtins;

let
  riverconfig = import ../../../../riverconfig.nix;
  chars   = request: pkgs.lib.strings.stringToCharacters request;

  method  = chars: index:
    let   char  =   elemAt chars index; in
    if    char  ==  " " || index >= length chars then ""
    else  char  +   method chars (index + 1);

  path    = chars: index: 
    let   char  =   elemAt chars index; in
    if    char  ==  "?" || index >= length chars then ""
    else  char  +   path chars (index + 1);
  
  _key    = chars:  index:
  if index < length chars then
    let char = elemAt chars index; in
    if char == "=" then ""
    else char + _key chars (index + 1)
  else "";

  _value = chars: index:
  if index < length chars then
    let char = elemAt chars index; in
    if char == "&" then ""
    else char + _value chars (index + 1)
  else "";

  params = chars: index:
    if index < length chars then
      let 
        paramkey = _key chars index;
        paramvalue = _value chars (index + stringLength paramkey + 1);
      in
     [{ key = paramkey; value = paramvalue; }] 
      ++ params chars (index + (stringLength (paramkey+paramvalue) + 2))
    else [];

  url = req:  
  { 
    method  = (method (chars req) 0); 
    path    = (path (chars req) (stringLength (method (chars req) 0) + 1)); 
    params  = params (chars req) (stringLength (path (chars req) (stringLength (method (chars req) 0) + 1)) + (stringLength (method (chars req) 0) + 1) + 1); 
  };
in
  if riverconfig.modules.river.http then
    url
  else "river.http is not enable"