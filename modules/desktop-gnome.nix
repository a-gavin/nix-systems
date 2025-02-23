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
  ];
  programs.wireshark.enable = true;

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
    evince # Document viewer
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
    tali # Game
    totem # Video player
    xterm # Also have to disable this
  ]);
  services.xserver.excludePackages = [ pkgs.xterm ];
}
