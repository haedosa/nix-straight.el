{

   inputs = {
     haedosa.url = "github:haedosa/flakes/22.05";
     nixpkgs.follows = "haedosa/nixpkgs";
     flake-utils.follows = "haedosa/flake-utils";
   };

  outputs = { self, nixpkgs, flake-utils, ...} @ inputs :
    {
      overlay = import ./overlay.nix;
    }
    //
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: { inherit inputs; })
            self.overlay
          ];
        };

      in {

        defaultPackage = pkgs.nix-straight;

      });



}
