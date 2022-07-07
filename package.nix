{
  program = "nix-server";
  domain = "localhost";
  port = 12345;
  email = "email@email.com";
  modules = {
    river.http = true;
  };
}