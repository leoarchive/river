{
  program = "nix-server";
  modules = {
    river.http = {
      server = {
        domain = "localhost";
        port = 12345;
        email = "teste@teste.com";
      };
    };
  };
}