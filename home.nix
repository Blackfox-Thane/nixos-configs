{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
	alacritty = "alacritty";
	kitty = "kitty";
	mango = "mango";
	nvim = "nvim";
	fuzzel = "fuzzel";
	waybar = "waybar";
	yazi = "yazi";
	zsh = "zsh";
  };
in

  {
  home.username = "thane";
  home.homeDirectory = "/home/thane";
  home.stateVersion = "26.05";

  programs.git = {
	enable = true;
	settings = {
	  user = {
		name = "Blackfox-Thane";
		email = "blackshadowxv15@gmail.com";
	  };
	  init.defaultBranch = "main";
	};
  };

  programs.bash = {
	enable = true;
	shellAliases = {
	  #config-nix = "/usr/bin/git --git-dir=$HOME/DotfilesBare/nixos-bare --work-tree=$HOME/DotfilesBare";
	  nrs = "sudo nixos-rebuild switch --flake .#nogitsune";
	};
  };

  programs.zsh = {
	enable = true;
	shellAliases = {
	  #config-nix = "/usr/bin/git --git-dir=$HOME/DotfilesBare/nixos-bare --work-tree=$HOME/DotfilesBare";
	  nrs = "sudo nixos-rebuild switch --flake .#nogitsune";
	};
  };

  programs.home-manager = {
	enable = true;
  };

  home.packages = with pkgs; [
	neovim
	fuzzel
	kitty
	yazi
	fastfetch
  ];

  xdg.configFile = builtins.mapAttrs
	(name: subpath: {
	  source = create_symlink "${dotfiles}/${subpath}";
	  recursive = true;
	})
	configs;
}
