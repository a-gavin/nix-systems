{ config, lib, pkgs, ... }:

let
  wg_ct-in_port = 22023;
  wg_ct-us_port = 22024;
in
{
  ### Firewall ###
  #
  # Add additional ports for WireGuard config
  networking.firewall = {
    allowedUDPPorts = [ wg_ct-us_port wg_ct-in_port ];
  };

  ### WireGuard ###
  #
  # This is managed through NetworkManager
  # TODO: Create and configure NetworkManager WireGuard in Nix
  #       keep private key in a separate file
  # Can do this w/ systemd-networkd possibly if use ActivatioPolicy=manual or similar
  # https://www.freedesktop.org/software/systemd/man/latest/systemd.network.html
}
