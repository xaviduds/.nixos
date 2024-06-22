{ pkgs, inputs, ... }:

let
  black = "000000";
  white = "ffffff";
  style = "bg:#${black} fg:#${white}";
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
      directories = [
        ".local/state/lazygit"
        ".local/share/Smart Code ltd/Stremio"
        ".stremio-server"
        ".nixos"
        ".vida"
        "lince"
        "xaviduds.github.io"
        ".ssh"
        ".mozilla"
        ".secrets"
        "projects"
        ".config/obsidian"
        ".config/gh"
        ".config/pulse"
      ];
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
        "pkill waybar"
        "waybar"
        "swww-daemon"
        "swww img ~/.nixos/wallpaper.png"
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
        "SUPER SHIFT, W, exec, waybar"
        "SUPER, W, exec, pkill waybar && waybar"
        "SUPER CONTROL, W, exec, pkill waybar"
        "SUPER, Q, exec, alacritty"
        "SUPER, P, exec, pavucontrol"
        "SUPER, F, exec, firefox"
        "SUPER, O, exec, obsidian"
        "SUPER, G, exec, gimp"
        "SUPER, T, exec, xterm"
        "SUPER, C, killactive"
        "SUPER, V, togglefloating"
        "SUPER, M, exit"
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER CONTROL, h, movewindow, l"
        "SUPER CONTROL, l, movewindow, r"
        "SUPER CONTROL, k, movewindow, u"
        "SUPER CONTROL, j, movewindow, d"
        "SUPER ALT, l, moveactive, 50 0"
        "SUPER ALT, h, moveactive, -50 0"
        "SUPER ALT, k, moveactive, 0 -50"
        "SUPER ALT, j, moveactive, 0 50"
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
        ", XF86AudioRaiseVolume,exec, amixer sset -q Master 5%+"
        ", XF86AudioLowerVolume,exec, amixer sset -q Master 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # && pkill waybar && waybar
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
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
    platformTheme = { name = "adwaita"; };
    style = { name = "adwaita-dark"; };
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
        eval "$(starship init bash)"
        tmux attach
        clear
        tmux
        clear
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
          "privacy.sanitize.pending" = ''
            [{"id":"shutdown","itemsToClear":["cache","offlineApps"],"options":{}},{"id":"newtab-container","itemsToClear":[],"options":{}}]'';
        };
        userChrome = ''
          /* Some css */
          body {background-color: #000000;}
        '';
        bookmarks = [{
          name = "whatsapp";
          tags = [ "whats" ];
          keyword = "whats";
          url = "https://web.whatsapp.com/";
        }];
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          # to search for extension's names: nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"
          darkreader
          news-feed-eradicator
          enhancer-for-youtube
          onetab
          privacy-badger
          ublock-origin
          videospeed
          web-archives
        ];
      };
    };

    git = {
      enable = true;
      userName = "xaviduds";
      userEmail = "xaviduds@gmail.com";
    };

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
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }];
    };

    starship = {
      enable = true;
      settings = {
        format = "$all";
        character = {
          success_symbol = "";
          error_symbol = "Ⲫ";
        };
        cmd_duration = { style = "${style}"; };
        directory = {
          style = "${style}";
          read_only = "⦵";
          read_only_style = "${style}";
          truncation_length = 10;
          truncate_to_repo = false;
        };
        git_branch = {
          symbol = " ";
          style = "${style}";
        };
        git_commit = { style = "${style}"; };
        git_state = { style = "${style}"; };
        git_status = { style = "${style}"; };
        nix_shell = {
          disabled = false;
          style = "${style}";
          impure_msg = "[impure shell](${white})";
          pure_msg = "[pure shell](${white})";
          unknown_msg = "[unknown shell](${white})";
          format = "via  [ ҉ $state( ($name))](${white}) ";
        };
      };
    };

    tmux = {
      enable = true;
      extraConfig = ''
        unbind r 
        bind-key h  select-pane -L
        bind-key j  select-pane -D
        bind-key k  select-pane -U
        bind-key l  select-pane -R
        bind-key C-h  resize-pane -L 5
        bind-key C-j  resize-pane -D 5
        bind-key C-k  resize-pane -U 5
        bind-key C-l  resize-pane -R 5
        set -s escape-time 0
        bind r source-file ~/.config/tmux/tmux.conf
        set -g prefix C-a
        set -g status off
        set -g status-interval 1
        set -g base-index 1
        set -g default-terminal "screen-256color"
        set -g mouse on
        set -g status-bg '#${black}'
        set -g status-fg '#${white}'
        set -g message-command-style fg='#${white}',bg='#${black}'           
        set -g message-style fg='#{$white}',bg='#${black}'
        set -g status-right ""
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-resurrect'
        run '~/.tmux/plugins/tpm/tpm' #git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      '';
    };

    waybar = {
      enable = true;
      systemd.enable = true;
      settings = [{
        layer = "top";
        position = "bottom";
        spacing = 10;
        modules-left = [ "custom/tmux" ];
        modules-center = [ "tray" ];
        modules-right = [
          "network"
          "memory"
          "temperature"
          "cpu"
          "disk"
          "clock"
          "pulseaudio"
          "battery"
        ];

        "battery" = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [ "🪫" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        "clock" = {
          interval = 1;
          format = "  {:%H:%M:%S %d/%m/%Y %A}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
          };
          "actions" = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "cpu" = {
          interval = 1;
          format = " {usage:2}%";
        };

        "custom/tmux" = {
          interval = 1;
          exec = "~/.nixos/tmux.sh";
          format = { };
        };

        "disk" = {
          interval = 1;
          format = "᠅ {used}/{total}";
        };

        "memory" = {
          interval = 1;
          format = " {}%";
        };

        "network" = {
          interval = 10;
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-disconnected = "󰤮 ";
          format-wifi =
            "↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes} {essid} {icon} {signalStrength}%";
          format-ethernet = " {bandwidthDownOctets}";
          on-click = "xterm -e nmtui";
        };

        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-muted = "︎︎︎︎︎︎ {︎format_source}";
          format-source = " {volume}%";
          format-source-muted = " {volume}%";
          format-icons = {
            headphone = "";
            default = [ "" "" " " ];
          };
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-middle = "amixer set Capture toggle";
        };

        "temperature" = {
          interval = 1;
          hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
          format = " {temperatureC}°C";
          critical-threshold = 80;
          format-critical = "🔥 {temperatureC}°C";
        };

        "tray" = { show-passive-items = true; };
      }];
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: JetBrainsMono Nerd Font;
        }
        window#waybar {
          background: #${black};
          color: #${white};
        }
        #workspaces button {
          padding: 0 5px;
        }
      '';
    };
  };
}
