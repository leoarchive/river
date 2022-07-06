with import <nixpkgs> {};

let
  configuration = import ./configuration.nix;
  script = pkgs.writeShellScriptBin "nix-server" 
  ''
    start() {
      echo "sudo nixos-rebuild switch"
      sudo nixos-rebuild switch      

      echo "sudo mkdir -p /var/www/${configuration.Program}"
      sudo mkdir -p /var/www/${configuration.Program}

      echo "sudo cp -r * /var/www/${configuration.Program}/"
      sudo cp -r * /var/www/${configuration.Program}/

      echo "sudo systemctl start nginx"
      sudo systemctl start nginx
    }

    update() {
      echo "sudo cp -r *.html /var/www/${configuration.Program}/"
      sudo cp -r *.html /var/www/${configuration.Program}/
    }
    "$@"
  '';
in
  stdenv.mkDerivation {
    name = "nix-server-environment";
    
    buildInputs = [
      script
    ];
  }