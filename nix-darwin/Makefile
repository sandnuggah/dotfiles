# please change 'hostname' to your hostname
deploy:
	nix build .#darwinConfigurations.Baggio.system \
	   --extra-experimental-features 'nix-command flakes'

	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#Baggio
