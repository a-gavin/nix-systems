{ config, pkgs, ... }:

{
  imports =
    [
      ./boot.nix
      ./hardware.nix
      ./monitoring.nix
    ];

  ### General System Settings ###
  #
  # Hostname
  networking.hostName = "mapuche";

  ### nix-daemon ###
  #
  # These are primarily options to ensure this resource-constrained system
  # is not overburdened during an intensive nix build
  #
  # Maximum number of jobs invoked in parallel
  # https://search.nixos.org/options?channel=unstable&show=nix.settings.max-jobs&&query=nix.settings
  nix.settings.max-jobs = 6;

  # Maximum number of concurrent tasks in a single build
  # Only honored by packages that support enableParallelBuilding
  # https://search.nixos.org/options?channel=unstable&show=nix.settings.cores&&query=nix.settings
  nix.settings.cores = 3;

  # This reduces maximum CPU usage during nix builds
  systemd.services.nix-daemon.serviceConfig = {
    # There are 6 cores, 12 hardware threads in the Ryzen 3600 chip
    # Permit max usage on 6 of 12 hardware threads
    CPUAccounting = true;
    CPUQuota = "600%";

    # Reduce memory usage, so that this plus user slice
    # doesn't exceed 16G
    MemoryAccounting = true;
    MemoryHigh = "3G";
    MemoryMax = "4G";
  };

  # This reduces the maximum amount of memory usage during nix builds
  systemd.slices."user-" = {
    overrideStrategy = "asDropin";

    sliceConfig = {
      MemoryAccounting = true;
      MemoryHigh = "10G";
      MemoryMax = "12G";
    };
  };
}
