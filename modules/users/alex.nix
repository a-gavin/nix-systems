{ config, pkgs, ... }:

{
  ### Core Nix User Config ###
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "dialout" # USB serial device permissions
      "input" # Mouse/keyboard permissions
      "plugdev" # Other USB device permissions
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      # arrendajo
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHN0etOw0cQcTny9JoqKlrLmAMmz5zJmaft5Z4Az8KJt''

      # caracara
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtqJRFcSi539mLSqEeIGiD4QUNZV/+8jMagiPsqSQqI''
    ];
  };
  nix.settings.trusted-users = [ "alex" ];

  ### Core Home-Manager User Config ###
  # https://nix-community.github.io/home-manager/index.xhtml#sec-usage-configuration
  home-manager.users.alex = {
    home.username = "alex";
    home.homeDirectory = "/home/alex";

    # Let Home Manager manager Bash
    # https://nix-community.github.io/home-manager/index.xhtml#_why_are_the_session_variables_not_set
    programs.bash.enable = true;

    # Packages in addition to those installed in base-cfg packages
    #
    # Only this user will have these packages available
    # Global packages available to all users
    home.packages = with pkgs; [
      nixpkgs-fmt
      pre-commit
    ];

    # Git configuration
    programs.git = {
      enable = true;
      userName = "Alex Gavin";
      userEmail = "a_gavin@icloud.com";
    };

    home.stateVersion = "24.11";
  };
}
