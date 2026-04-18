{
  description = "copland nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    oceanix.url = "github:LEXUGE/oceanix";
    copetch.url = "github:elwrcl/copetch";

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

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-cachyos-kernel,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        copland = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            { nixpkgs.hostPlatform = system; }
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.default
                (final: prev: {
                  copetch = inputs.copetch.packages.${system}.default;
                })
              ];
              nixpkgs.config.allowUnfree = true;

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
