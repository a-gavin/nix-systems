{
  disko.devices = {
    disk.nvme0n1 = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          BOOT = {
            type = "EF00";
            size = "1G";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          PRIMARY = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "vg1";
            };
          };
        };
      };
    };
    disk.nvme1n1 = {
      type = "disk";
      device = "/dev/nvme1n1";
      content = {
        type = "gpt";
        partitions = {
          EMPTY = {
            size = "1G";
            content = {
              type = "filesystem";
              format = "vfat";
            };
          };
          PRIMARY = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "vg1";
            };
          };
        };
      };
    };
    lvm_vg = {
      vg1 = {
        type = "lvm_vg";
        lvs = {
          SWAP = {
            size = "16G";
            content = {
              type = "swap";
            };
          };
          NIX = {
            size = "100G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
              mountOptions = [
                "noatime"
              ];
            };
          };
          ROOT = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
