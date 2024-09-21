{ inputs, pkgs, pkgs-stable, user, hmModules, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = {inherit inputs user pkgs-stable;};
    users.${user} = {
      imports = hmModules;
    };
    backupFileExtension = ".bak";
  };

}

