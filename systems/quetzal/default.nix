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
}
