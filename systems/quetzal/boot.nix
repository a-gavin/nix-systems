{ modulesPath, lib, pkgs, ... }:

{
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "xen_blkfront"
    "virtio_gpu"
  ];
  boot.initrd.kernelModules = [ "nvme" ];

  # No swap device if use 'nix-infect' on default Hetzner Debian image
  # so this enables in-memory compressed devices to still allow for
  # some swap space
  zramSwap.enable = true;
}
