init:
	nix-channel --add https://nixos.org/channels/nixos-18.09 nixos
	nix-channel --add https://nixos.org/channels/nixos-18.09 nixpkgs
	nix-channel --update
backup:
	cp -R /etc/nixos /etc/nixos_$(date +%Y-%m-%d)
	cp -R . /etc/nixos
virtualbox: backup
	cd /etc/nixos && ln -s machines/virtualbox.nix hardware-configuration.nix
	nixos-rebuild switch
