{ pkgs, inputs, ... }:

{
  imports =
    [ ./hardware-configuration.nix inputs.home-manager.nixosModules.default ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs = {
    hyprland.enable = true;
    dconf.enable = true;
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "eduardo" = import ./home.nix; };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };
  console.keyMap = "br-abnt2";

  sound.enable = true;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  users.users.eduardo = {
    isNormalUser = true;
    description = "eduardo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [ nerdfonts ];

  environment = {
    systemPackages = with pkgs; [
      acpi
      alacritty
      brightnessctl
      btop
      eww
      gnome.adwaita-icon-theme
      helix
      hyprland
      feh
      firefox
      git
      gopls
      gscreenshot
      lazygit
      libreoffice
      lua-language-server
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      obsidian
      ollama
      pavucontrol
      postgresql
      python311Packages.python-lsp-server
      rofi-wayland
      rust-analyzer
      starship
      stremio
      telegram-desktop
      tmux
      unzip
      zip
      zls
      waybar
      wireplumber
      wl-clipboard
      wlogout
      yazi
    ];
    shellAliases = {
      "sshgithub" =
        "rm -rf ~/.ssh && ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub";
      "u" =
        "sudo nix flake update ~/nixos/ && sudo nixos-rebuild switch --flake ~/nixos#default --impure";
      "t" = "tmux";
      "h" = "hx";
      "y" = "yazi";
      "aa" = "git add .";
      "s" = "git status";
      "p" = "git push";
      "a" = "git add";
      "c" = "git commit";
      "lg" = "lazygit";
      "e" = "exit";
    };
  };
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "lince" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        				local all       all     trust
        				host all       all     127.0.0.1/32   trust
        				host all       all     ::1/128        trust		
        				'';
    };
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
  };

  system = { stateVersion = "23.11"; };

  nix = { settings.experimental-features = [ "nix-command" "flakes" ]; };

}

