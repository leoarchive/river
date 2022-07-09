{
  program = "nix-server";
  modules = {
    river.http = true;
    river.server = {
      domain = "localhost";
      port = 12345;
      email = "teste@teste.com";
    };
  };
}