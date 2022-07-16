# before start you need to import the nginx configuration file in your configuration.nix,
# read more in the file ./configuration.nix;
# afer import you can start with the command:
#
#   nix-shell river/default/http/server/shell.nix
#
with import <nixpkgs> {};

let
  riverconfig = import ../../../../riverconfig.nix;
  script = pkgs.writeShellScriptBin "river.server" 
  ''
    start() {
      echo "sudo nixos-rebuild switch"
      sudo nixos-rebuild switch      

      echo "sudo mkdir -p /var/www/${riverconfig.program}"
      sudo mkdir -p /var/www/${riverconfig.program}

      echo "sudo cp -r * /var/www/${riverconfig.program}/"
      sudo cp -r * /var/www/${riverconfig.program}/

      echo "sudo systemctl start nginx"
      sudo systemctl start nginx
    }

    update() {
      echo "sudo cp -r *.html /var/www/${riverconfig.program}/"
      sudo cp -r *.html /var/www/${riverconfig.program}/
    }
    "$@"
  '';
in
  if riverconfig.modules.river.http.server != null then 
    stdenv.mkDerivation {
      name = "nix-server-environment";
      
      buildInputs = [
        script
      ];
    }
  else "river.server is not enable"
  