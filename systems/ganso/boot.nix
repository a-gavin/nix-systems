{ config, lib, pkgs, modulesPath, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 'dm-raid' kernel module required for LVM configuration
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-raid" ];
  boot.kernelModules = [ "kvm-amd" "dm-raid" ];
  boot.extraModulePackages = [ ];


  # Boot latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
  # Turn on Intel IOMMU
  #
  # NixOS Linux kernel config doesn't set 'CONFIG_INTEL_IOMMU_DEFAULT_ON', so
  # the kernel will default to off (and use SWIOTLB bounce buffering only)
  #
  #boot.kernelParams = [
  #  "intel_iommu=on"
  #];
}
