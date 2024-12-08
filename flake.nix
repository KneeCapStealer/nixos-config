{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    hyprland.url = "github:hyprwm/Hyprland";

    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, catppuccin, erosanix, ... } @ inputs:
  let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.hyprland.overlays.default ];

        config.allowUnfree = true;
      };
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        erosanix.nixosModules.protonvpn

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = { inherit inputs; };

          home-manager.users.chris = {
            imports = [
              ./users/chris.nix
              catppuccin.homeManagerModules.catppuccin
            ];
          };
        }

        # COLOR THEME
        catppuccin.nixosModules.catppuccin
      ];
    };

  };
}
