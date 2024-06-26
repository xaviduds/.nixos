{ pkgs, inputs, ... }:

let
  black = "000000";
  white = "ffffff";
  # style = "bg:#${black} fg:#${white}";
  colorPalette = {
    black = "#${white}";
    red = "#${white}";
    green = "#${white}";
    yellow = "#${white}";
    blue = "#${white}";
    magenta = "#${white}";
    cyan = "#${white}";
    white = "#${white}";
  };
in {
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];
  home = {
    persistence."/persist/home/eduardo" = {
      directories =
        [ ".nixos" "vida" "lince" "xaviduds.github.io" ".ssh" ".mozilla" ];
      allowOther = true;
    };
    username = "eduardo";
    homeDirectory = "/home/eduardo";
    stateVersion = "23.11";
    sessionVariables = { EDITOR = "hx"; };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1";
      exec-once = [
        "firefox"
        "obsidian"
        "sleep 5 && wpctl set-volume @DEFAULT_SOURCE@ 0.1"
      ];
      input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        kb_model = "abnt2";
        numlock_by_default = "yes";
      };
      general = {
        gaps_in = "0";
        gaps_out = "0";
        border_size = "0";
      };
      animations = { enabled = "false"; };
      misc = { disable_hyprland_logo = "true"; };
      bind = [
        "SUPER, Q, exec, alacritty"
        "SUPER, P, exec, pavucontrol"
        "SUPER, F, exec, firefox"
        "SUPER, T, exec, xterm -e nmtui"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER SHIFT, l, resizeactive, 50 0"
        "SUPER SHIFT, h, resizeactive, -50 0"
        "SUPER SHIFT, k, resizeactive, 0 -50"
        "SUPER SHIFT, j, resizeactive, 0 50"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        "SUPER, Print, exec, gscreenshot --selection"
        ", XF86AudioRaiseVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
        ", XF86AudioLowerVolume,exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "SUPER,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SOURCE@ 0.01+"
        "SUPER,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SOURCE@ 0.01-"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
  programs = {
    home-manager.enable = true;

    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 0;
            y = 0;
          };
          decorations = "none";
        };
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold Italic";
          };
        };
        colors = {
          primary = {
            background = "0x${black}";
            foreground = "0x${white}";
          };
          normal = colorPalette;
          bright = colorPalette;
          dim = colorPalette;
        };
      };
    };

    bash = {
      enable = true;
      initExtra = ''
        tmux attach
        clear
        tmux
        clear
        bash ~/.nixos/fetch.sh
      '';
    };
    firefox = {
      enable = true;
      profiles.default = {
        settings = {
          "browser.download.panel.shown" = true;
          "signon.rememberSignons" = false;
          "browser.newtabpage.enabled" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.aboutConfig.showWarning" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.translations.automaticallyPopup" = false;
        };
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          privacy-badger
          ublock-origin
          videospeed
        ];
      };
    };

    # git = {
    #   enable = true;
    #   userName = "xaviduds";
    #   userEmail = "xaviduds@gmail.com";
    # };

    helix = {
      enable = true;
      settings = {
        theme = "blackEwhite";
        keys = {
          normal = {
            "C-e" = "increment";
            "A-j" =
              [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
            "A-k" = [
              "extend_to_line_bounds"
              "delete_selection"
              "move_line_up"
              "paste_before"
            ];

          };
        };
        editor = {
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          line-number = "relative";
        };
      };
      themes = {
        blackEwhite = {
          "ui.menu.selected" = { modifiers = [ "reversed" ]; };
          "ui.selection" = {
            fg = black;
            bg = white;
          };
          "ui.selection.primary" = { modifiers = [ "reversed" ]; };
          "ui.cursor" = { modifiers = [ "reversed" ]; };
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
          indent = {
            tab-width = 4;
            unit = " ";
          };
        }
        {
          name = "python";
          auto-format = true;
        }
      ];
    };

    tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 1;
      newSession = false;
      resizeAmount = 5;
      shortcut = "a";
      mouse = true;
      disableConfirmationPrompt = true;
      extraConfig = ''
        bind-key h  select-pane -L
        bind-key j  select-pane -D
        bind-key k  select-pane -U
        bind-key l  select-pane -R
        bind-key C-h  resize-pane -L 5
        bind-key C-j  resize-pane -D 5
        bind-key C-k  resize-pane -U 5
        bind-key C-l  resize-pane -R 5
        set -g message-style fg='#{$white}',bg='#${black}'
        set -g status off
      '';
    };
  };
}
