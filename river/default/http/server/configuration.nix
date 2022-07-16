# river server module.
# for start you need to import this directory in your configuration.nix;
# you can get the directory with:
#
#   echo $PWD/river/default/http/server/configuration.nix
#
# and in your configuration.nix:
#
#   imports = [ <output> ];
#
let 
  riverconfig = import ../../../../riverconfig.nix;
in
{
  security.acme.acceptTerms = true;
  security.acme.certs = {
    ${toString riverconfig.modules.river.server.domain} = {
      email = riverconfig.modules.river.server.email;
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
      ${toString riverconfig.modules.river.server.domain} = {
        addSSL = true;
        enableACME = true;
        locations."/" = { root = "/var/www/${riverconfig.program}/"; };
        listen = [{ port = riverconfig.modules.river.server.port; addr="0.0.0.0"; ssl=true; }];
      };
    };
  };
}