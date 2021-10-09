update:
	sudo nix flake update --update-input nixpkgs
	sudo nix flake update --update-input nixpkgs-unstable
rebuild:
	sudo nixos-rebuild switch
cache:
	cachix push mmai /nix/store/$$(readlink -f $$(which VirtualBox) | awk -F'/' '{print $$4}')
install:
	sudo ln -s $$(pwd) /etc/nixos
