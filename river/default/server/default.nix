# before start you need to import the nginx configuration file in your configuration.nix,
# read more in the file ./configuration.nix;
# afer import you can start with the command:
#
#   nix-shell river/default/server
#
with import <nixpkgs> {};

let
  package = import ../../../package.nix;
  script = pkgs.writeShellScriptBin "river.server" 
  ''
    start() {
      echo "sudo nixos-rebuild switch"
      sudo nixos-rebuild switch      

      echo "sudo mkdir -p /var/www/${package.program}"
      sudo mkdir -p /var/www/${package.program}

      echo "sudo cp -r * /var/www/${package.program}/"
      sudo cp -r * /var/www/${package.program}/

      echo "sudo systemctl start nginx"
      sudo systemctl start nginx
    }

    update() {
      echo "sudo cp -r *.html /var/www/${package.program}/"
      sudo cp -r *.html /var/www/${package.program}/
    }
    "$@"
  '';
in
  if package.modules.river.server.enable == true
  then 
    stdenv.mkDerivation {
      name = "nix-server-environment";
      
      buildInputs = [
        script
      ];
    }
  else "river.server is not enable"
  