{ config, lib, pkgs, modulesPath, ... }:

{
  ### systemd-networkd ###
  # 
  # Default is NetworkManager. Enabling systemd-networkd will
  # disable NetworkManager. However, also need to set global
  # interface DHCP client setting to off
  #
  # Based on system requirements, override this w/ 'lib.mkForce' as necessary
  networking.useDHCP = false;

  # Uncomment this to enable systemd-networkd debug logging
  # systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
  systemd.network = {
    enable = true;

    # Enables DHCP client on all interfaces
    networks."99-lan" = {
      matchConfig.Name = "*";
      networkConfig.DHCP = "ipv4";
    };
  };

  ### Firewall ###
  #
  # For now only SSH, whose port appears to be allowed in
  # the firewall when enabled
  networking.firewall.enable = true;

  ### Networking services ###
  #
  # NOTE: May need to enable services' ports in firewall as well

  # Enable sshd and default nixpkgs fail2ban
  # Default configuration has pre-configured SSH jails
  services.fail2ban.enable = true;
  services.openssh = {
    enable = true;

    # Non-standard port and open on firewall (default but set to be explicit)
    ports = [ 26626 ];
    openFirewall = true;

    # Standard security settings (no root login, key auth only)
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
