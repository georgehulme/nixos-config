{
  description = "NixOS System Wrapper Flake Configuration";

  inputs = {};

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix 
      ];
    };
  };
}
