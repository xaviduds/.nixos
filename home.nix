{ inputs, config, pkgs, ... }:

{
  home = {
    username = "eduardo";
    homeDirectory = "/home/eduardo";
    stateVersion = "23.11";
    file = {
      ".alacritty.toml".source =
        "${config.home.homeDirectory}/nixos/alacritty/.alacritty.toml";
      ".config/rofi/".source = "${config.home.homeDirectory}/nixos/rofi/";
      ".config/helix/themes/xaviduds.toml".source =
        "${config.home.homeDirectory}/nixos/helix/themes/xaviduds.toml";
      ".config/eww/".source = "${config.home.homeDirectory}/nixos/eww/";
      ".config/wlogout/".source = "${config.home.homeDirectory}/nixos/wlogout/";
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

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = { name = "adwaita-dark"; };
  };
  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      initExtra = ''
        eval "$(starship init bash)"
        tmux attach
        tmux
        clear
      '';
    };
    git = {
      enable = true;
      userName = "xaviduds";
      userEmail = "xaviduds@gmail.com";
    };
    waybar = {
      enable = true;
      systemd.enable = true;
      style = "";
      settings = [{
        height = 30;
        layer = "top";
        position = "right";
        modules-left = [ "clock" "battery" "memory" "cpu" "jack" ];
        modules-center = [ "hyprland" ];
        modules-right = [ "privacy" ];
        battery = {
          format = "{capacity}%";
          format-alt = "{time}";
        };
        clock = {
          format = ''
            {:%H
             ..
            %M

            %dd
            %mm
            %YY
            }'';
        };
      }];
    };
    tmux = {
      enable = true;
      #git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      extraConfig = ''
        unbind r 
        bind r source-file ~/.config/tmux/tmux.conf

        set -g prefix C-a
        set -g status-interval 1
        set -g base-index 1
        set -s escape-time 0

        bind-key h  select-pane -L
        bind-key j  select-pane -D
        bind-key k  select-pane -U
        bind-key l  select-pane -R

        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'catppuccin/tmux'
        set -g @plugin 'tmux-plugins/tmux-resurrect'

        set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_right_separator " "
        set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_number_position "right"
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#{b:pane_current_path}"
        set -g @catppuccin_status_modules_right "session"
        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_right_separator_inverse "no"
        set -g @catppuccin_status_fill "icon"
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_directory_text "#{pane_current_path}"

        run '~/.tmux/plugins/tpm/tpm'
      '';
    };
    helix = {
      enable = true;
      settings = {
        theme = "xaviduds";
        editor = {
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          line-number = "relative";
        };
      };
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }];
    };
    starship = {
      enable = true;
      settings = {
        format = "$all";
        nix_shell = {
          disabled = false;
          impure_msg = "[impure shell](bold red)";
          pure_msg = "[pure shell](bold green)";
          unknown_msg = "[unknown shell](bold yellow)";
          format = "via [☃️ $state( ($name))](bold blue) ";
        };
      };
    };
    /* firefox = {
          enable = true;
          profiles.default = {
            extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
              #enhancer-for-youtube
              ublock-origin
              darkreader
              news-feed-eradicator
              return-youtube-dislikes
              to-google-translate
              privacy-badger
              videospeed
              search-by-image
            ];
            bookmarks = [
              {
                name = "whats";
                tags = [ "whatsapp" ];
                keyword = "zap";
                url = "https://web.whatsapp.com";
              }
              {
                name = "github";
                url = "github.com";
              }
              {

              }
            ];
            settings = {
              "browser.download.dir" = builtins.getEnv "HOME";
              "browser.download.folderList" = 1;
              "browser.toolbars.bookmarks.visibility" = "always";
            };
          };
        };
    */
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1";
      exec-once = [ "firefox" "pkill waybar" "waybar" ];
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
        "SUPER SHIFT, W, exec, waybar"
        "SUPER, W, exec, pkill waybar && waybar"
        "SUPER CONTROL, W, exec, pkill waybar"
        "SUPER, Q, exec, alacritty"
        "SUPER, P, exec, pavucontrol"
        "SUPER, S, exec, stremio"
        "SUPER, F, exec, firefox"
        "SUPER, O, exec, obsidian"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, R, exec, rofi -show drun -show-icons -terminal wezterm -scroll-method 1 -click-to-exit"
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER CONTROL, h, movewindow, l"
        "SUPER CONTROL, l, movewindow, r"
        "SUPER CONTROL, k, movewindow, u"
        "SUPER CONTROL, j, movewindow, d"
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
        ", XF86AudioRaiseVolume,exec, volume --inc"
        ", XF86AudioLowerVolume,exec, volume --dec"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
    };
  };
}
