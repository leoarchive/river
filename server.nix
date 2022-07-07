let 
  package = import ./package.nix;
in
{
  security.acme.acceptTerms = true;
  security.acme.certs = {
    ${toString package.domain} = {
      email = package.email;
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
      ${toString package.domain} = {
        addSSL = true;
        enableACME = true;
        locations."/" = { root = "/var/www/${package.program}/"; };
        listen = [{ port = package.port; addr="0.0.0.0"; ssl=true; }];
      };
    };
  };
}