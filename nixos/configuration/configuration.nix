# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 15;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adar = {
    isNormalUser = true;
    description = "Adar";
    extraGroups = ["networkmanager" "wheel" "video"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  xdg.mime.defaultApplications = {
    "application/pdf" = "zathura.desktop";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    mako
    libnotify
    stow
    zig
    ripgrep
    wl-clipboard
    zoxide
    fzf
    kanshi
    wdisplays
    rofi-wayland
    wirelesstools
    bc
    pamixer
    playerctl
    dash
    gnome.gnome-system-monitor
    zathura
    thefuck
    evolution

    lua-language-server
    stylua

    cargo
    rustc
    clippy
    rust-analyzer
    rustfmt

    gcc

    python3
    nodePackages.pyright

    nil

    unzip
    fd
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack"];})
  ];
  fonts.enableDefaultPackages = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  programs = {
    firefox = {
      enable = true;
    };
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    steam.enable = true;
    xwayland.enable = true;
    light.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --time --cmd 'sway --unsupported-gpu'";
        user = "greeter";
      };
    };
  };

  services.upower.enable = true;

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.autoUpgrade = {
    enable = true;
    flake = "''";
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "07:00";
    randomizedDelaySec = "45min";
  };
}
