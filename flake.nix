{
  description = "copland nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, chaotic, home-manager, ... }:
    let
      system = "x86_64-linux";
      
      chaoticOverlay = chaotic.overlays.default;
      
    in {
    nixosConfigurations = {
      copland = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs system; 
          zen-browser = inputs.zen-browser;
        };

        modules = [
          chaotic.nixosModules.default
          
          home-manager.nixosModules.home-manager

          {
            nixpkgs.overlays = [ chaoticOverlay ];
            nixpkgs.config.allowUnfree = true;
          }

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs system; };
              users.elars = import ./home;
            };
          }

          ./machine.nix
          ./nixos/default.nix
        ];
      };
    };
  };
}