{ config, lib, pkgs, modulesPath, ... }:

{
  systemd.network.enable = lib.mkForce false;

  # TODO: Rework this into systemd-networkd once identify issue
  # https://github.com/NixOS/nixpkgs/issues/375960
  networking = {
    nameservers = [
      "2a01:4ff:ff00::add:2"
      "2a01:4ff:ff00::add:1"
      "185.12.64.2"
    ];
    defaultGateway = "172.31.1.1";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="162.55.50.213"; prefixLength=32; }
        ];
        ipv6.addresses = [
          { address="2a01:4f8:c2c:f7a1::1"; prefixLength=64; }
          { address="fe80::9400:4ff:fe16:579e"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "172.31.1.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "fe80::1"; prefixLength = 128; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="96:00:04:16:57:9e", NAME="eth0"
    
  '';
}
