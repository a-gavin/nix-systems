{
  disko.devices = {
    disk.sda = {
      type = "disk";
      device = "/dev/sda";
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
    disk.sdb = {
      type = "disk";
      device = "/dev/sdb";
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
            size = "8G";
            content = {
              type = "swap";
            };
          };
          NIX = {
            size = "50G";
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
