{ config, lib, pkgs, modulesPath, ... }:

{
  ### Kernel ###
  #
  # Always enable serial and virtual console
  # Kernel logs will be output to both
  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty"
  ];

  ### Misc ###
  #
  # nix uses systemd's tmp.conf defaults, which delete /tmp after 10d
  boot.tmp.cleanOnBoot = true;
}
