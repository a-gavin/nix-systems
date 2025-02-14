{ modulesPath, lib, pkgs, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    ./boot.nix
    ./hardware.nix
    ./network.nix
  ];

  ### General System Settings ###

  # Hostname
  networking.hostName = "quetzal";

  # Override default timezone (set in base-cfg)
  time.timeZone = lib.mkForce "Europe/Berlin";

  users.users.alex = {
    isNormalUser = true; 
    description = "alex";     
    extraGroups = [ "wheel" ];                                                                                           
    packages = with pkgs; [ ];                       
  };

  # Authorized SSH keys for login
  users.users.alex.openssh.authorizedKeys.keys = [
    # meadowlark
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsP8EyhP0NJDIJS7rOmI9D7az4V4e+z0efanMSDg1PK''

    # caracara
    # TODO
  ];
}
