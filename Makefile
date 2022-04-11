update:
	sudo nix flake update
rebuild:
	#sudo nixos-rebuild switch
	sudo nixos-rebuild switch --flake .#$$(hostname)
cache:
	cachix push mmai /nix/store/$$(readlink -f $$(which VirtualBox) | awk -F'/' '{print $$4}')
install:
	sudo ln -s $$(pwd) /etc/nixos
dist-upgrade:
	echo "Edit flake.nix with new nixpkgs.url"
