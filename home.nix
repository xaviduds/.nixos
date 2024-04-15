{ pkgs, ... }:

let
  base00 = "1e1e2e"; # base (cinza azulado escuro)
  base01 = "181825"; # mantle (preto azulado cinza)
  base02 = "313244"; # surface0 (cinza escuro)
  base03 = "45475a"; # surface1 (cinza medio)
  base04 = "585b70"; # surface2 (cinza medio-claro)
  base05 = "cdd6f4"; # text (cinza azulado claro)
  base06 = "f5e0dc"; # rosewater (pastel claro)
  base07 = "b4befe"; # lavender (cor de amaciante)
  base08 = "f38ba8"; # salmao (salmão)
  base09 = "fab387"; # peach (laranja claro)
  base0A = "f9e2af"; # amareloClaro
  base0B = "a6e3a1"; # verdeClaro (verde claro)
  base0C = "94e2d5"; # teal (ciano)
  base0D = "89b4fa"; # azulClaro (azul claro)
  base0E = "cba6f7"; # mauve (lilás)
  base0F = "f2cdcd"; # flamingo

  base = "1e1e2e";
  baseQuasePreta = "181825";
  baseEscura = "313244";
  baseMedia = "45475a";
  baseMediaClara = "585b70";
  cinzaAzuladoClaro = "cdd6f4";
  pastelClaro = "f5e0dc";
  amaciante = "b4befe";
  salmao = "f38ba8";
  laranjaClaro = "fab387";
  amareloClaro = "f9e2af";
  verdeClaro = "a6e3a1";
  ciano = "94e2d5";
  azulClaro = "89b4fa";
  lilas = "cba6f7";
  corDePorco = "f2cdcd";

in {
  home = {
    username = "eduardo";
    homeDirectory = "/home/eduardo";
    stateVersion = "23.11";
    sessionVariables = { EDITOR = "hx"; };
    file = { };
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
            background = "0x${base00}";
            foreground = "0x${base05}";
            dim_foreground = "0x${base05}";
            bright_foreground = "0x${base05}";
          };

          cursor = {
            text = "0x${base00}";
            cursor = "0x${base06}";
          };

          vi_mode_cursor = {
            text = "0x${base00}";
            cursor = "0x${base07}";
          };

          search = {
            matches = {
              foreground = "0x${base00}";
              background = "0xa6adc8";
            };
            focused_match = {
              foreground = "0x${base00}";
              background = "0x${base0B}";
            };
          };

          footer_bar = {
            foreground = "0x${base00}";
            background = "0xa6adc8";
          };

          hints = {
            start = {
              foreground = "0x${base00}";
              background = "0x${base0A}";
            };
            end = {
              foreground = "0x${base00}";
              background = "0xa6adc8";
            };
          };

          selection = {
            text = "0x${base00}";
            background = "0x${base06}";
          };
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

    git = {
      enable = true;
      userName = "xaviduds";
      userEmail = "xaviduds@gmail.com";
    };

    helix = {
      enable = true;
      settings = {
        themes = {
          "ui.menu" = "none";
          "ui.menu.selected" = { modifiers = [ "reversed" ]; };
          "ui.linenr" = {
            fg = baseMedia;
            bg = base01;
          };
          "ui.popup" = { modifiers = [ "reversed" ]; };
          "ui.linenr.selected" = {
            fg = base05;
            bg = base01;
            modifiers = [ "bold" ];
          };
          "ui.selection" = {
            fg = base01;
            bg = azulClaro;
          };
          "ui.selection.primary" = { modifiers = [ "reversed" ]; };
          "comment" = { fg = base03; };
          "ui.statusline" = {
            fg = pastelClaro;
            bg = base;
          };
          "ui.statusline.inactive" = {
            fg = base;
            bg = pastelClaro;
          };
          "ui.help" = {
            fg = base;
            bg = pastelClaro;
          };
          "ui.cursor" = { modifiers = [ "reversed" ]; };
          "variable" = salmao;
          "variable.builtin" = laranjaClaro;
          "constant.numeric" = laranjaClaro;
          "constant" = laranjaClaro;
          "attributes" = amareloClaro;
          "type" = amareloClaro;
          "ui.cursor.match" = {
            fg = amareloClaro;
            modifiers = [ "underlined" ];
          };
          "string" = verdeClaro;
          "variable.other.member" = salmao;
          "constant.character.escape" = ciano;
          "function" = azulClaro;
          "constructor" = azulClaro;
          "special" = azulClaro;
          "keyword" = salmao;
          "label" = salmao;
          "namespace" = azulClaro;
          "diff.plus" = verdeClaro;
          "diff.delta" = amareloClaro;
          "diff.minus" = salmao;
          "diagnostic" = { modifiers = [ "underlined" ]; };
          "ui.gutter" = { bg = base01; };
          "info" = azulClaro;
          "hint" = base;
          "debug" = base;
          "warning" = amareloClaro;
          "error" = salmao;
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
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }];
    };

    rofi = {
      enable = true;
      extraConfig = {
        modi = "drun";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = "alacritty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "";
        sidebar-mode = true;
      };
      theme = "DarkBlue";
    };
    starship = {
      enable = true;
      settings = {
        format = "$all";
        nix_shell = {
          disabled = false;
          impure_msg = "[impure shell](bold ${salmao})";
          pure_msg = "[pure shell](bold ${verdeClaro})";
          unknown_msg = "[unknown shell](bold ${amareloClaro})";
          format = "via [☃️ $state( ($name))](bold ${azulClaro}) ";
        };
      };
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

        # set -g @catppuccin_window_left_separator ""
        # set -g @catppuccin_window_right_separator " "
        # set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_number_position "right"
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_current_fill "number"
        set -g @catppuccin_window_current_text "#{b:pane_current_path}"
        set -g @catppuccin_status_modules_right "session"
        # set -g @catppuccin_status_left_separator  " "
        # set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_right_separator_inverse "no"
        set -g @catppuccin_status_fill "icon"
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_directory_text "#{pane_current_path}"

        set -g default-terminal "screen-256color"
        set -g status-bg black
        set -g status-fg white
        run '~/.tmux/plugins/tpm/tpm'
      '';
    };

    waybar = {
      enable = true;
      systemd.enable = true;
      settings = [{
        layer = "top";
        position = "top";

        modules-center = [ "hyprland/workspaces" ];
        modules-left =
          [ "custom/startmenu" "hyprland/window" "pulseaudio" "cpu" "memory" ];
        modules-right = [
          "custom/hyprbindings"
          "custom/exit"
          "idle_inhibitor"
          "custom/themeselector"
          "custom/notification"
          "battery"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = " {:L%I:%M %p}";
          tooltip = true;
          tooltip-format =
            "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 25;
          separate-outputs = false;
          rewrite = { "" = " 🙈 No Windows? "; };
        };
        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "network" = {
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = { spacing = 12; };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-azulClarotooth = "{volume}% {icon} {format_source}";
          format-azulClarotooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "custom/themeselector" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && theme-selector";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = " ";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && rofi-launcher";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = " Bindings";
          on-click = "sleep 0.1 && list-hypr-bindings";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='${salmao}'><sup></sup></span>";
            none = "";
            dnd-notification =
              "<span foreground='${salmao}'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification =
              "<span foreground='${salmao}'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification =
              "<span foreground='${salmao}'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          on-click = "";
          tooltip = false;
        };
      }];
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: Source Code Pro;
        }
        window#waybar {
          background: #16191C;
          color: #AAB2BF;
        }
        #workspaces button {
          padding: 0 5px;
        }
      '';
    };
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
        "SUPER, R, exec, rofi -show drun -show-icons -steal-focus -terminal alacritty -scroll-method 1 -click-to-exit"
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
