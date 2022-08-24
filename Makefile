update:
	nix flake lock --update-input nixpkgs --update-input guix --update-input nixpkgs-unstable --update-input mydist
rebuild:
	#sudo nixos-rebuild switch
	sudo nixos-rebuild switch --flake .#$$(hostname)
cache:
	cachix push mmai /nix/store/$$(readlink -f $$(which VirtualBox) | awk -F'/' '{print $$4}')
install:
	sudo ln -s $$(pwd) /etc/nixos
dist-upgrade:
	echo "Edit flake.nix with new nixpkgs.url"
