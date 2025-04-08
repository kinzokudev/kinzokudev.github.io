{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:Misterio77/nix-colors";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      systems = lib.systems.flakeExposed;
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      colorScheme = inputs.nix-colors.colorSchemes.catppuccin-frappe;
    in
    {
      devShells = forEachSystem (pkgs: {
        default = import ./shell.nix { inherit pkgs; };
      });
      packages = forEachSystem (pkgs: {
        default = pkgs.writeShellApplication {
          name = "update-colorscheme";
          runtimeInputs = with pkgs; [ gnused ];
          text = lib.concatStringsSep "\n" (
            lib.attrsets.mapAttrsToList (
              name: value: "sed -i '/--${name}/s/#.\\{6\\}/#${value}/' src/styles/global.css"
            ) colorScheme.palette
          );
        };
      });
    };
}
