{ config, lib, pkgs, modulesPath, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 'dm-raid' kernel module required for LVM configurations
  # TODO: Document setup process in README for LVM configs:
  # 1. Config disko config
  # 2. Apply disko config
  # 3. Generate nixos base w/ --no-filesystem and --root /mnt
  #    * Do this after disko config otherwise will be wiped
  # 4. Edit config based on blog post
  #    * Make sure to add the 'dm-raid' module
  # 5. Install
  # 6. On first boot, use system custom config
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-raid" ];
  boot.kernelModules = [ "kvm-amd" "dm-raid" ];
  boot.extraModulePackages = [ ];

  # Boot latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
