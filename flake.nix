{
  description = "Personal development machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, vscode-server }: {
    nixosConfigurations."mapuche" = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        # TODO: Move me to base-cfg/default.nix
        vscode-server.nixosModules.default
        ({ config, pkgs, ... }: {
          services.vscode-server.enable = true;
        })

        ./base-cfg/default.nix
        ./systems/mapuche/default.nix
      ];
    };

    nixosConfigurations."quetzal" = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      modules = [
        # TODO: Move me to base-cfg/default.nix
        vscode-server.nixosModules.default
        ({ config, pkgs, ... }: {
          services.vscode-server.enable = true;
        })

        ./base-cfg/default.nix
        ./systems/quetzal/default.nix
      ];
    };
  };
}
