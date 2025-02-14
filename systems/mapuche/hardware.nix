{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  ### General HW Settings ###
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable emulation for cross compile builds w/o having to rebuild
  # all binaries (Nixpkg binary cache only includes binaries for native builds)
  # See: https://wiki.nixos.org/wiki/Cross_Compiling#Leveraging_the_binary_cache
  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  ### Filesystem/Disks ###
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/0e16a44b-1d8b-4041-9157-bccd8c7ddb7f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/EC94-06E1";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/356efdde-2bbb-49ff-94d1-26436878c7da"; }
    ];
}
