{ config, pkgs, ... }:

{
  ### Desktop Packages ###
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Required packages
    font-awesome
    hyprpolkitagent # Authentication daemon
    kitty # Graphical terminal (required by default Hyperland)
    libsForQt5.dolphin # File manager
    wofi # Launcher/menu program

    # Other packages
    firefox
    thunderbird
    vscode
    wireshark
  ];

  ### Hyprland Requirements/Other Nice-to-Haves ###

  # Pipewire
  #
  # Enable optional RTKit (recommended for best audio experience)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # iwd
  #
  # Add WiFi daemon for desktop usage only
  networking.wireless.iwd.enable = true;

  # System fonts
  #
  # Much of this is to address icon issues in waybar (desktop taskbar)
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      font-awesome
      liberation_ttf
      nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto-mono
    ];
  };

  # Configure system behavior via power profiles
  # Used by waybar config
  services.power-profiles-daemon.enable = true;

  # X Server to allow interfacing to X11 apps w/ Wayland protocol
  programs.xwayland.enable = true;

  # Authentication deamon
  #
  # Also use hyprpolkitagent for use in this Hyprland setup
  security.polkit.enable = true;

  # Enable Bluetooth support
  hardware.bluetooth.enable = true;


  ### Hyprland ###

  # Batteries not included. Configure following recommended
  # options for basic, screen-sharing capable desktop environment
  #
  # Must have:
  #   - Notification daemon^
  #   - Sound^
  #       + Pipewire explicitly recommended
  #       + Pipewire also includes wireplumber^
  #   - XDG Desktop Portal^
  #       + Enabled by default in Nix Hyprland config
  #   - Authentication agent
  #       + hyprpolkit explicitly recommended
  #   - Qt Wayland Support
  #       + TODO: Investigate libsForQt5.qt5.qtwayland nixpkg
  #   - XWayland^
  #       + Discord screensharing
  #
  # ^ = Required for screensharing
  #
  # See following Hyprland docs:
  #   - https://wiki.hyprland.org/Useful-Utilities/Must-have/
  #   - https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  programs.waybar.enable = true;
}
