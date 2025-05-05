{
  description = "Personal machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko = {
      # https://github.com/nix-community/disko/blob/master/docs/HowTo.md#installing-nixos-module
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = ""; # Save resources by disabling Darwin dependencies
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, disko, home-manager, agenix, vscode-server }: {
    # arrendajo
    nixosConfigurations."arrendajo" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        vscode-server.nixosModules.default

        ./systems/arrendajo/default.nix
        ./base-cfg/default.nix
        ./modules/desktop-gnome.nix

        ./users/alex/default.nix
        ./users/alex/agenix.nix
      ];
    };

    # motmot
    nixosConfigurations."motmot" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        vscode-server.nixosModules.default

        ./systems/motmot/default.nix
        ./base-cfg/default.nix

        ./users/alex/default.nix
      ];
    };

    # quetzal
    nixosConfigurations."quetzal" = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      modules = [
        vscode-server.nixosModules.default

        ./systems/quetzal/default.nix
        ./base-cfg/default.nix

        ./users/alex/default.nix
      ];
    };
  };
}
