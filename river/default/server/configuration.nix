# river server module.
# for start you need to import this directory in your configuration.nix;
# you can get the directory with:
#
#   echo $PWD/river/default/server/configuration.nix
#
# and in your configuration.nix:
#
#   imports = [ <output> ];
#
let 
  package = import ../../../package.nix;
in
{
  security.acme.acceptTerms = true;
  security.acme.certs = {
    ${toString package.modules.river.server.domain} = {
      email = package.modules.river.server.email;
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
      ${toString package.modules.river.server.domain} = {
        addSSL = true;
        enableACME = true;
        locations."/" = { root = "/var/www/${package.program}/"; };
        listen = [{ port = package.modules.river.server.port; addr="0.0.0.0"; ssl=true; }];
      };
    };
  };
}