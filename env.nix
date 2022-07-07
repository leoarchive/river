with import <nixpkgs> {};

let
  package = import ./package.nix;
  script = pkgs.writeShellScriptBin "nix-server" 
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
  stdenv.mkDerivation {
    name = "nix-server-environment";
    
    buildInputs = [
      script
    ];
  }