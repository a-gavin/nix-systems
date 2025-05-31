{ config, lib, pkgs, ... }:

{
  ### Override Defaults ###
  #
  # These defaults are included from base-cfg
  #
  # Disable systemd-networkd. GNOME uses NetworkManager by default
  # Retain other networking config, though (sshd, firewall)
  networking.useDHCP = lib.mkForce true;
  systemd.network.enable = lib.mkForce false;

  ### Desktop Packages ###
  nixpkgs.config.allowUnfree = true;

  # Global
  environment.systemPackages = with pkgs; [
    firefox
    mattermost-desktop # client application
    remmina
    thunderbird
    vscode
    wireshark
    zola # Static website generator, not GUI-only but really only gonna use on GUI workstation
    zotero
  ];

  # Wireshark-specific config
  #
  # Overlay gets more recent version of Wireshark, as 25.05
  # channel which currently using does not support decoding
  # Wi-Fi RSN Element Override IEs
  #
  # Unfortunately, even Wireshark's recent v4.4 release candidates
  # don't include the patch adding RSN override support...which
  # is from over nine months ago....
  #
  # Documentation links:
  #   - Development roadmap: https://wiki.wireshark.org/Development/Roadmap
  #   - Development lifecycle: https://wiki.wireshark.org/Development/LifeCycle
  programs.wireshark.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      wireshark = prev.wireshark.overrideAttrs (old: {
        version = "826dd1d";

        src = pkgs.fetchFromGitLab {
          repo = "wireshark";
          owner = "wireshark";
          rev = "826dd1d";
          hash = "sha256-vSJqtAPlA5NVPRSyRk6seYhh0+dQFk4BUk4KmGrVlZY=";
        };

        # Recently introduced libxml2 dependency
        buildInputs = [ pkgs.libxml2 ] ++ old.buildInputs;

        patches = [
          ./patches/lookup-dumpcap-in-path.patch
        ];
      });
    })
  ];

  ### GNOME Config ###
  #
  # Enable X11 windowing system
  services.xserver.enable = true;

  # Enable sound through Pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable GNOME desktop environment
  #
  # This brings in quite a lot of dependencies
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Exclude some default-installed GNOME packages
  # https://nixos.wiki/wiki/GNOME#Excluding_some_GNOME_applications_from_the_default_install
  environment.gnome.excludePackages = (with pkgs; [
    atomix # Puzzle game
    baobab # Disk usage analyzer
    cheese # Webcam tool
    epiphany # Web browser
    geary # Email reader
    gedit # Text editor
    gnome-characters
    gnome-connections # VNC/RDP client
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-system-monitor
    gnome-terminal
    gnome-tour
    gnome-weather
    hitori # Game
    iagno # Game
    simple-scan # Scanners
    #snapshot  # Camera app (useful to verify camera for meeting)
    tali # Game
    totem # Video player
    xterm # Also have to disable this
  ]);
  services.xserver.excludePackages = [ pkgs.xterm ];
}
