{
  description = "My personal flake";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

	disko = {
	  url = "github:nix-community/disko";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
	home-manager = {
	  url = "github:nix-community/home-manager";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
	mango = {
	  url = "github:DreamMaoMao/mango";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, disko, home-manager, mango, ... }:
	let 
	  lib = nixpkgs.lib;
	  system = "x86_64-linux";
	  pkgs = nixpkgs.legacyPackages.${system};
	in {
	  nixosConfigurations = {
		nogitsune = lib.nixosSystem {
		  inherit system;
		  specialArgs = {inherit inputs;};
		  modules = [ ./configuration.nix ];
		};
	  };
	  homeConfgurations = {
		nogitsune = home-manager.lib.homeManagerConfguration {
		  inherit pkgs;
		  modules = [ ./home.nix ];
		};
	  };
	};

}
