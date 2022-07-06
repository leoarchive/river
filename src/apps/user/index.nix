[
  {
    path = "/User";
    method = "GET";
    module = import ./list.nix;
  }
  {
    path = "/User/create";
    method = "PUT";
    module = import ./create.nix;
  }
]