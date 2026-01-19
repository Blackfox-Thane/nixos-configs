{
	disko.devices = {
		disk = {
			main = {
				device = "/dev/vda";
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							priority = 1;
							label = "boot";
							name = "ESP";
							size = "512M";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "umask=0077" ];
							};
						};
						root = {
							size = "100%";
							content = {
								type = "btrfs";
								extraArgs = [ "-f" ];
								subvolumes = {
									"/" = {
										mountpoint = "/";
									};
									"/home" = {
										mountOptions = [ "compress=zstd" ];
										mountpoint = "/home";
									};
									"/nix" = {
										mountOptions = [ "compress=zstd" "noatime" ];
										mountpoint = "/nix";
									};
									"/swap" = {
										mountpoint = "/.swapvol";
										swap.swapfile.size = "8G";
									};
								};
							};
						};
					};
				};
			};
		};
	};
}
