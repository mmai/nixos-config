init:
	nix-channel --add https://nixos.org/channels/nixos-18.09 nixos
	nix-channel --add https://nixos.org/channels/nixos-18.09 nixpkgs
	nix-channel --add https://nixos.org/channels/nixos-unstable unstable
	nix-channel --update
install:
	sudo ln -s $$(pwd)/configuration.nix /etc/nixos/myconfig.nix
	echo "Add ./myconfig.nix in /etc/nixos/configuration.nix imports"
