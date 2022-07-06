let 
  configuration = import ./configuration.nix;
in
{
  security.acme.acceptTerms = true;
  security.acme.certs = {
    ${toString configuration.Domain} = {
      email = configuration.Email;
    };
  };

  services.nginx = {
    enable = true;

    #recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      ${toString configuration.Domain} = {
        addSSL = true;
        enableACME = true;
        locations."/" = { root = "/var/www/${configuration.Program}/"; };
        listen = [{ port = configuration.Port; addr="0.0.0.0"; ssl=true; }];
      };
    };
  };
}