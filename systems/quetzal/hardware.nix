{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B564-D046";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
}