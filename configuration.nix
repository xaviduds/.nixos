{ pkgs, inputs, ... }: {
  imports =
    [ ./hardware-configuration.nix inputs.home-manager.nixosModules.default ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
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
      bat
      brightnessctl
      btop
      eza
      gnome.adwaita-icon-theme
      helix
      hyprland
      feh
      firefox
      gimp
      git
      gopls
      gscreenshot
      lazygit
      libreoffice
      lua-language-server
      man
      marksman
      mesa
      neofetch
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
      swww
      tmux
      unzip
      zip
      zls
      waybar
      wireplumber
      wl-clipboard
      yazi
    ];
    shellAliases = {
      "sshgithub" =
        "rm -rf ~/.ssh && ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub";
      "u" =
        "sudo nix flake update ~/.nixos/ && sudo nixos-rebuild switch --flake ~/.nixos#default --impure";
      "t" = "tmux";
      "h" = "hx";
      "y" = "yazi";
      "aa" = "git add .";
      "s" = "if [ -d .git ]; then git status; fi";
      "p" = "git push";
      "gp" = "git pull";
      "a" = "git add";
      "c" = "git commit";
      "lg" = "lazygit";
      "e" = "exit";
      "z" =
        "clear && eza -T -L 2 --icons=always --group-directories-first -s name -I .git -lh --no-user --no-permissions --git-repos --git --no-time && s";
      "n" = "cd ~/.nixos && z";
      "lp" = "cd ~/.lincePessoal && z";
      "lc" = "cd ~/lince && z";
      "x" = "cd ~/xaviduds.github.io && z";
      "dc" = "cd ~/ && z";
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

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system = { stateVersion = "23.11"; };
}
