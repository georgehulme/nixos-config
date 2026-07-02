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
    ''
    -----BEGIN CERTIFICATE-----
    MIIF3TCCA8WgAwIBAgIUVHCcZdZ/Wo/rEU9GgKRsBrQ3DJwwDQYJKoZIhvcNAQEL
    BQAwfjELMAkGA1UEBhMCR0IxDjAMBgNVBAgMBUxvY2FsMQ4wDAYDVQQHDAVMb2Nh
    bDESMBAGA1UECgwJQ29taGFpcmxlMQwwCgYDVQQLDANEZXYxLTArBgNVBAMMJENv
    bWhhaXJsZSBTdGFnZSBMb2NhbCBNYXN0ZXIgVGVzdCBDQTAeFw0yNjA3MDExNzE0
    NTlaFw0zNjA2MjgxNzE0NTlaMH4xCzAJBgNVBAYTAkdCMQ4wDAYDVQQIDAVMb2Nh
    bDEOMAwGA1UEBwwFTG9jYWwxEjAQBgNVBAoMCUNvbWhhaXJsZTEMMAoGA1UECwwD
    RGV2MS0wKwYDVQQDDCRDb21oYWlybGUgU3RhZ2UgTG9jYWwgTWFzdGVyIFRlc3Qg
    Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC3fDGS05D1mGkxOCnw
    LNAUEgUoz5RzLebwALuDLNU0IkWdhjCEtLK1WeGnsNwjc5pSoVHAQ+BoRapYrkHs
    uakUqo95Jehntyl6MpdyAhQlJBCReLZIck+iViaY4FQvO/qm1rzTfcDkZqUa9e2w
    L0YcoRXsoNq0k7aci6QhVzRruxbQyfDrz/+7DFAKQsV+/GooC85v7a+OR01qW1O3
    FtIzIXmzZjWvv5vK2Qfv53jVWqhncI4U0CjDTsru6UZ39lmvouhUsIIXRbofkC+P
    dQNVvI0snXWpXkEejJ9Ge8Pt83//Nrb2t485uZ+z2NrWfLqAyypSO1qCFX/KgSw5
    bCpGUbxEhlwL2X9IXCjGTvUC0bhD17m7uh/8lmQ5tdnwsUgZbyYS7Hz6Htu5HpIq
    IfTMnlJw2w/KTdMkMdsZf6YZDIH4Au+oDUkEdj8VUiV1CSBNqzcQ651slnm69P3o
    QzpUayFaw7jeOibdwltNo9Cy+9NzksC+lt4QQRapO1Y3E7MGxw+h3zvSvRx2Q20f
    dLRuAdzYS/vOhDgVOsbcXGFXoWFvpd8rtlowRCZpHYICKG6tOZnXmipW+GCepNJt
    PMpZWTM8eAqvI1RenysYHwb20bCUI8NsoOj9Ho7fGIxU6vKRxhLiVE9HN3bynzj+
    uCw/unrBuxGWNp78WSOvQUv0EQIDAQABo1MwUTAdBgNVHQ4EFgQU8agjiQZ3iIcM
    nDjMvTqxn8kFJtwwHwYDVR0jBBgwFoAU8agjiQZ3iIcMnDjMvTqxn8kFJtwwDwYD
    VR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAgEAABIpxVF6/dCD9TM61mp7
    mOIejaKDE5kK9BFLQuqH8nDPP+bAIWF7TVmkHD27R9sSzi9FvExQWdE6bbxpRH+k
    tlgx1hjV/41YRkyJEXAeKQ96Jjn697ytp/h650QvWUxcmY7ezE3j2tsaxFFlYljI
    rvQW9HKTSbliIDopQWQlzjq/jl2xFo9cZudPCMS63XKSABofX9udz0XoPoCdbDhs
    tAVuKyU6QQ14j7QXsKfQNs19RP0M5DA1IrMOAGjYT0yX3AforPbw4i28dzT5Limo
    dVmtN46KROgVM+1WCb1BpJzFc7Kl/xWQRqX83iTYD9SX2GrjrPuacVk2I7e4gdFt
    LTay9BPjsROuouh3u7G44catxPMf2+QXkxEUjT+zgyYAl+nuZocSR9YWHUqN6uKa
    PsHjwYyZqMRo+Omqz55aKXn88IZX8kRDVlt5jBX9G2FKXBg89qsAlT7gurfQfSFG
    TqnG7bKFXJXXG8PPDHl/h3UUWcOqU9rltTcMEoAajBkx/hd9SFwMbbDMh9+K7jV7
    7reIHZC8ZSDw4xrJYE+3WT6gnvlK/2pbmjyuUqfip8k9fN8Yp+GBG+oCz5ZEhXFH
    rrIkgc08/zAC8bmb1fsdjBt5tGOpB1g/ZJBOPHeCA5p5wl32w0Zat02yn1Z9fJZZ
    NSTwjH/mHCkLFlFM5VFO3Js=
    -----END CERTIFICATE-----
    ''
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
    packages = [
      pkgs.google-chrome
      pkgs.direnv
      pkgs.discord
      pkgs.docker
      pkgs.gcc
      pkgs.ghostty
      pkgs.git
      pkgs.github-cli
      pkgs.kdePackages.kate
      pkgs.kdePackages.wayland
      pkgs.mesa
      pkgs.rustup
      pkgs.sccache
      pkgs.vscode
      pkgs.wayland
      pkgs.wget
      pkgs.xclip
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

  # Install firefox.
  programs.firefox.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.neovim.enable = true;
  programs.tmux.enable = true;

  # System packages
  environment.systemPackages = [
    pkgs.gpu-screen-recorder-gtk
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
