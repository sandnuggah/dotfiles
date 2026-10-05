.PHONY: deploy update bootstrap

# Apply the config (also available as `nix-deploy` from any directory).
deploy:
	sudo darwin-rebuild switch --flake .#Baggio

# Update everything, then deploy (also available as `nix-update`):
# the flake inputs (nixpkgs, nix-darwin, home-manager), Homebrew itself,
# and every cask and App Store app in the Brewfile.
update:
	nix flake update
	brew update
	brew bundle upgrade
	$(MAKE) deploy

# First install, before darwin-rebuild is on PATH.
bootstrap:
	nix build .#darwinConfigurations.Baggio.system --out-link /tmp/baggio-system
	sudo /tmp/baggio-system/sw/bin/darwin-rebuild switch --flake .#Baggio
