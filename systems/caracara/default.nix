{ config, pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./disk-config.nix
      ./hardware.nix
      ./network.nix
    ];

  ### General System Settings ###
  #
  # Hostname
  networking.hostName = "caracara";
}
