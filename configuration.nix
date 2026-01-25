{ config, lib, pkgs, ... }:

{
  imports =
    [ 
	  ./hardware-configuration.nix
	];

  boot.loader.refind.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nogitsune";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.thane = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
	alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  services.openssh = {
          enable = true;
          ports = [ 22 ];
          settings = {
        	  PasswordAuthentication = false;
        	  AllowUsers = null;
        	  UseDns = true;
        	  X11Forwarding = false;
        	  PermitRootLogin = "prohibit-password";
          };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

}
