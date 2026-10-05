.PHONY: deploy bootstrap upgrade

# Apply the config (also available as `nix-deploy` from any directory).
deploy:
	sudo darwin-rebuild switch --flake .#Baggio

# First install, before darwin-rebuild is on PATH.
bootstrap:
	nix build .#darwinConfigurations.Baggio.system --out-link /tmp/baggio-system
	sudo /tmp/baggio-system/sw/bin/darwin-rebuild switch --flake .#Baggio

# Update Homebrew apps; deploys only install and remove them.
upgrade:
	brew update
	brew bundle upgrade
