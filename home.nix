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
      directories = [
        ".nixos"
        ".vida"
        "lince"
        "xaviduds.github.io"
        ".ssh"
        ".mozilla"
        "projects"
        # ".config/pulse"
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
        position = "top";
        spacing = 8;
        modules-left = [ "custom/tmux" "tray" ];
        modules-center = [ "clock" ];
        modules-right = [
          # "custom/volume"
          # "custom/microphone"
          "pulseaudio"
          "custom/wallpaper"
          "temperature"
          "network"
          "battery"
        ];

        "battery" = {
          format = "{icon}";
          states = { critical = 20; };
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        "clock" = {
          interval = 1;
          format = "{:%H:%M:%S %d/%m/%Y %A}";
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

        "custom/microphone" = {
          interval = 1;
          exec = "~/.nixos/waybar_scripts/microphone.sh";
          format = { };
          on-click = "pavucontrol";
          on-click-middle = "wpctl set-volume @DEFAULT_SOURCE@ 0";
          on-click-right = "amixer set Capture toggle";
        };

        "custom/volume" = {
          interval = 1;
          exec = "~/.nixos/waybar_scripts/volume.sh";
          format = { };
          on-click = "pavucontrol";
          on-click-middle = "amixer sset -q Master 0%";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "custom/tmux" = {
          interval = 1;
          exec = "~/.nixos/waybar_scripts/tmux.sh";
          format = { };
        };

        "custom/wallpaper" = {
          on-click = "~/.nixos/waybar_scripts/wallpaper_changer.sh";
          format = "δ";
        };

        "disk" = {
          interval = 1;
          format = "{used}";
        };

        "memory" = {
          interval = 1;
          format = " {avail:2.0f}GB";
        };

        "network" = {
          interval = 10;
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-disconnected = "󰤮 ";
          format-wifi = "{icon} ";
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
          format = "";
          critical-threshold = 80;
          format-critical = "";
        };

        "tray" = { show-passive-items = true; };
      }];
      style = ''
        * {
          border: none;
          font-family: JetBrainsMono Nerd Font;
          font-size: 15px;
          min-height: 10px
        }

        window#waybar {
          background: transparent;
          color: #ffffff;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #network,
        #battery,
        #custom-tmux,
        #custom-wallpaper,
        #custom-volume,
        #custom-microphone,
        #clock,
        #disk,
        #temperature,
        #cpu,
        #memory,
        #pulseaudio {
          margin-top: 6px;
          margin-left: 2px;
          padding-left: 10px;
          padding-right: 10px;
          margin-bottom: 6px;
          border-radius: 5px;
          transition: none;
          box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;

          color: #000000;
        }

        #network {
          background: #bd93f9;
        }

        #custom-tmux {
          padding-right: 20px;
          box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
          padding-left: 20px;
          padding-bottom: 3px;
          background: rgb(203, 166, 247);
          background: radial-gradient(circle, rgba(203, 166, 247, 1) 0%, rgba(193, 168, 247, 1) 12%, rgba(249, 226, 175, 1) 19%, rgba(189, 169, 247, 1) 20%, rgba(182, 171, 247, 1) 24%, rgba(198, 255, 194, 1) 36%, rgba(177, 172, 247, 1) 37%, rgba(170, 173, 248, 1) 48%, rgba(255, 255, 255, 1) 52%, rgba(166, 174, 248, 1) 52%, rgba(160, 175, 248, 1) 59%, rgba(148, 226, 213, 1) 66%, rgba(155, 176, 248, 1) 67%, rgba(152, 177, 248, 1) 68%, rgba(205, 214, 244, 1) 77%, rgba(148, 178, 249, 1) 78%, rgba(144, 179, 250, 1) 82%, rgba(180, 190, 254, 1) 83%, rgba(141, 179, 250, 1) 90%, rgba(137, 180, 250, 1) 100%);
          background-size: 400% 400%;
          animation: gradient_f 20s ease-in-out infinite;
          transition: all 0.3s cubic-bezier(.55, -0.68, .48, 1.682);
        }

        @keyframes gradient {
          0% {
            background-position: 0% 50%;
          }

          50% {
            background-position: 100% 30%;
          }

          100% {
            background-position: 0% 50%;
          }
        }

        @keyframes gradient_f {
          0% {
            background-position: 0% 200%;
          }

          50% {
            background-position: 200% 0%;
          }

          100% {
            background-position: 400% 200%;
          }
        }

        @keyframes gradient_f_nh {
          0% {
            background-position: 0% 200%;
          }

          100% {
            background-position: 200% 200%;
          }
        }

        #memory {
          background: #DDB6F2;
        }
        #custom-volume {
          background: #DDB6F2;
        }
        #custom-microphone {
          background: #DDB6F2;
        }

        #clock {
          background: #ABE9B3;
        }

        #custom-wallpaper {
          background: #F8BD96;
        }

        #disk {
          background: #F8BD96;
        }

        #temperature {
          background: #96CDFB;
        }

        #temperature.critical {
          background: #db5344;
        }

        #cpu {
          background: #FAE3B0;
        }

        #pulseaudio {
          background: #FAE3B0;
        }

        #battery {
          background: #B5E8E0;
        }

        #battery.critical:not(.charging) {
          background-color: #B5E8E0;
          color: #161320;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        @keyframes blink {
          to {
            background-color: #BF616A;
            color: #B5E8E0;
          }
        }
      '';
    };
  };
}
