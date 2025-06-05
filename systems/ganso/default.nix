{ config, pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./disk-config.nix
      ./hardware.nix
    ];

  ### General System Settings ###
  #
  # Hostname
  networking.hostName = "ganso";
}
