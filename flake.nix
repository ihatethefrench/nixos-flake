{

  description = "Michal's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
 
  {
    nixosConfigurations."nixos-station" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./station/hardware.nix
        ./station/base.nix
        ./station/dev.nix
	./station/gaming.nix
        
        ./common/kde.nix
	./common/media.nix
        ./common/nix.nix
        ./common/personal.nix
        ./common/yubikey.nix

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.michal = import ./common/michal.nix;
        }
      ];
    };

    nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./laptop/base.nix
	./laptop/hardware.nix	

        ./common/kde.nix
        ./common/media.nix
        ./common/nix.nix
        ./common/personal.nix
        ./common/yubikey.nix
        
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.michal = import ./common/michal.nix;
        }
      ];
    };
  
  };

}
