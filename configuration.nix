{ inputs, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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

  users.users.eduardo = {
    isNormalUser = true;
    description = "eduardo";
    initialPassword = "1";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [ ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "eduardo" = import ./home.nix; };
  };
  programs = {
    hyprland.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
  };

  networking = {
    wireless.iwd = {
      enable = true;
      settings = {

        IPv6 = { Enabled = true; };
        Settings = { AutoConnect = true; };
      };
    };
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
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
      kitty
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
      pavucontrol
      postgresql
      python311Packages.python-lsp-server
      rofi-wayland
      rust-analyzer
      starship
      swww
      tmux
      unzip
      vscode-langservers-extracted
      zip
      zls
      waybar
      wireplumber
      where-is-my-sddm-theme
      wl-clipboard
      yazi
    ];
    shellAliases = {
      "sshgithub" =
        "rm -rf ~/.ssh && ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub";
      "u" =
        "sudo nix flake update ~/.nixos/ && sudo nixos-rebuild switch --flake ~/.nixos#default --impure";
      "jn" = "jupyter notebook";
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
      "nd" = "nix flake update && nix develop && z";
      "ns" = "nix-shell";
      "n" = "cd ~/.nixos && z";
      "lp" = "cd ~/.lincePessoal && z";
      "lc" = "cd ~/lince && z";
      "x" = "cd ~/xaviduds.github.io && z";
      "dc" = "cd ~/ && z";
      ".." = "cd ..";
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
      displayManager.sddm = {
        enable = true;
        theme = "where-is-my-sddm-theme";
      };
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

  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -" # create /persist/home owned by root
    "d /persist/home/eduardo 0700 eduardo users -" # /persist/home/<user> owned by that user
  ];

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

