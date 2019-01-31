init:
	nix-channel --add https://nixos.org/channels/nixos-18.09 nixos
	nix-channel --add https://nixos.org/channels/nixos-18.09 nixpkgs
	nix-channel --update
backup:
	cp -R /etc/nixos /etc/nixos_$$(date +%Y-%m-%d)
	cp -R . /etc/nixos
virtualbox: backup
	cd /etc/nixos && ln -s machines/virtualbox.nix hardware-configuration.nix
	nixos-rebuild switch
desktop:
	sudo ln -s $$(pwd)/configuration.nix /etc/nixos/myconfig.nix
	echo "Add ./myconfig.nix in /etc/nixos/configuration.nix imports"
home_manager:
	nix-channel --add https://github.com/rycee/home-manager/archive/release-18.09.tar.gz home-manager
	nix-channel --update
	echo "exit and start a new session, then launch: nix-shell '<home-manager>' -A install"
