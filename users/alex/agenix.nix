{ config, ... }:

{
  ### Agenix config ###
  age = {
    identityPaths = [ "/home/alex/.ssh/id_ed25519" ];
    secrets = {
      ssh_hosts = {
        file = ./agenix/ssh_hosts.age;
        path = "/home/alex/.ssh/ssh_hosts.inc";
        owner = "alex";
      };
      git_config = {
        file = ./agenix/git_config.age;
        path = "/home/alex/.config/git/config.inc";
        owner = "alex";
      };
    };
  };

  ### Agenix-specific Home Manager Config ###
  home-manager.users.alex = {
    # SSH configuration
    #
    # Relies on user Agenix config above.
    # Required 'enable' set to 'true' in order for
    # config to take effect (set in standard user config)
    programs.ssh = {
      includes = [ config.age.secrets.ssh_hosts.path ];
    };

    # Git configuration
    programs.git = {
      includes = [
        { path = config.age.secrets.git_config.path; }
      ];
    };
  };
}
