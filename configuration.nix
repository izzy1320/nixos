{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "intel_pstate=active" ];
  boot.kernelModules = [ "ntsync" ];
  
  # Graphics
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Networking.
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";


  # Time Zone.
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # User Account.
  users.users."izzy" = {
    isNormalUser = true;
    description = "izzy";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
 
  # Environment Variables
  environment.sessionVariables = {
    FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
 
  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    curl
    git
    vim
    wl-clipboard
    pavucontrol
    adwaita-icon-theme
    wlogout
    starship
    fastfetch
    protonup-qt
    helix
    nwg-look
    btop-cuda
    grim
    slurp
    waybar
    xwayland-satellite
    swaynotificationcenter
    swayidle
    swaylock
    swaybg
    swayosd
    fuzzel
    ghostty
    zip
    unzip
    p7zip
    brave-origin
    xdg-utils
    xdg-user-dirs
    mpv
    yt-dlp
  ];

  # Programs W/ Modules
  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;

  # Security
  security.rtkit.enable = true;

  # Services
  services.flatpak.enable = true;
 
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.ubuntu-mono
      ubuntu-classic
    ];
  };

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    
   hinting = {
     enable = true;
     style = "slight";
   };
   subpixel = {
     rgba = "rgb";
     lcdfilter = "default";
   };
  };
 
  # Flakes & Nix Commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
 
  system.stateVersion = "26.05"; 

}
