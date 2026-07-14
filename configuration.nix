{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Enable flake usage
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure console keymap
  console.keyMap = "uk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Trusted CA certificates
  security.pki.certificates = [
    "/home/george/Projects/work/helm_charts/.local/certs/master-test-ca.crt"
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # My user
  users.users."george" = {
    isNormalUser = true;
    description = "George Hulme";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    # User packages
    packages = with pkgs; [
      discord
      direnv
      docker
      gcc
      ghostty
      git
      github-cli
      google-chrome
      haruna
      kdePackages.kate
      kdePackages.wayland
      mesa
      nordpass
      obsidian
      ripgrep
      rustup
      sccache
      vscode
      wayland
      wget
      wgnord
      xclip

    ];
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Setup passwordless sudo
  security.sudo.extraRules = [
    {
      users = [ "george" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
	}
      ];
    }
  ];

  programs.gnupg.agent.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.neovim.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Headless browser dependencies
      atk
      cairo
      dbus
      fontconfig
      gcc
      gio-sharp
      glib
      gtk3
      libx11
      libxcb
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxrender
      libxft
      libxi
      nspr
      nss
      pango
      rubyPackages.gdk3
    ];
  };
  programs.tmux.enable = true;

  # System packages
  environment.systemPackages =
    let
      zen-browser = import (builtins.fetchTarball {
        url = "https://github.com/youwen5/zen-browser-flake/archive/master.tar.gz";
	sha256 = "sha256:17fwqzsrnvkyzazgs33x2bjs77270j4rjw32p6wksr9y3zx4ra8z";
      }) {
        inherit pkgs;
      };
    in
  [
    pkgs.gpu-screen-recorder-gtk
    zen-browser.default
  ];
  
  environment.shellAliases = {
    rebuild-system = "sudo nixos-rebuild switch --flake /etc/nixos";
    update-system = "sudo nix flake update /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.11";
}
