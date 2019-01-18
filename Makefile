backup:
	cp -R /etc/nixos /etc/nixos_$(date +%Y-%m-%d)
	cp -R . /etc/nixos
virtualbox: backup
	cd /etc/nixos && ln -s machines/virtualbox.nix hardware-configuration.nix
	nix-env rebuild --switch
