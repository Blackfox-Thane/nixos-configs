{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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

	outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: {
		nixosConfigurations.nogi-nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
					inputs.disko.nixosModules.disko
					home-manager.nixosModules.home-manager
					mango.nixosModules.mango
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.thane = import ./home.nix;
						};
						programs.mango.enable = true;
					}
			];
		};
	};
}
