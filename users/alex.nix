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

  # Agenix config
  age = {
    identityPaths = [ "/home/alex/.ssh/id_ed25519" ];
    secrets = {
      ssh_hosts = {
        file = ../secrets/ssh_hosts.age;
        path = "/home/alex/.ssh/ssh_hosts.inc";
        owner = "alex";
      };
      git_config = {
        file = ../secrets/git_config.age;
        path = "/home/alex/.config/git/config.inc";
        owner = "alex";
      };
    };
  };

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
      clang-tools
      cmake
      gdb
      git
      nixpkgs-fmt
      pre-commit
    ];

    # SSH configuration
    #
    # Relies on user Agenix config above.
    # Required 'enable' set to 'true' in order for
    # config to take effect
    programs.ssh = {
      enable = true;
      #includes = [ (lib.removePrefix config.agenix.secrets.ssh_hosts.path) ];
      includes = [ config.age.secrets.ssh_hosts.path ];
    };

    # Git configuration
    programs.git = {
      enable = true;
      includes = [
        { path = config.age.secrets.git_config.path; }
      ];
    };

    home.stateVersion = "24.11";
  };
}
