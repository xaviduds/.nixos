{ inputs, config, pkgs, ... }:

{
  home = {
    username = "eduardo";
    homeDirectory = "/home/eduardo";
    stateVersion = "23.11";
    sessionVariables = { EDITOR = "hx"; };
    file = {
      ".config/alacritty/alacritty.toml".text = ''
        [window]
        padding = { x = 0, y = 0 }
        decorations = "None"

        [font.bold]
        family = "JetBrainsMono Nerd Font"
        style = "Bold"

        [font.bold_italic]
        family = "JetBrainsMono Nerd Font"
        style = "Bold Italic"

        [font.italic]
        family = "JetBrainsMono Nerd Font"
        style = "Italic"

        [font.normal]
        family = "JetBrainsMono Nerd Font"
        style = "Regular"

        [colors.primary]
        background = "#1E1E2E"
        foreground = "#CDD6F4"
        dim_foreground = "#CDD6F4"
        bright_foreground = "#CDD6F4"

        [colors.cursor]
        text = "#1E1E2E"
        cursor = "#F5E0DC"

        [colors.vi_mode_cursor]
        text = "#1E1E2E"
        cursor = "#B4BEFE"

        [colors.search.matches]
        foreground = "#1E1E2E"
        background = "#A6ADC8"

        [colors.search.focused_match]
        foreground = "#1E1E2E"
        background = "#A6E3A1"

        [colors.footer_bar]
        foreground = "#1E1E2E"
        background = "#A6ADC8"

        [colors.hints.start]
        foreground = "#1E1E2E"
        background = "#F9E2AF"

        [colors.hints.end]
        foreground = "#1E1E2E"
        background = "#A6ADC8"

        [colors.selection]
        text = "#1E1E2E"
        background = "#F5E0DC"

        [colors.normal]
        black = "#45475A"
        red = "#F38BA8"
        green = "#A6E3A1"
        yellow = "#F9E2AF"
        blue = "#89B4FA"
        magenta = "#F5C2E7"
        cyan = "#94E2D5"
        white = "#BAC2DE"

        [colors.bright]
        black = "#585B70"
        red = "#F38BA8"
        green = "#A6E3A1"
        yellow = "#F9E2AF"
        blue = "#89B4FA"
        magenta = "#F5C2E7"
        cyan = "#94E2D5"
        white = "#A6ADC8"

        [colors.dim]
        black = "#45475A"
        red = "#F38BA8"
        green = "#A6E3A1"
        yellow = "#F9E2AF"
        blue = "#89B4FA"
        magenta = "#F5C2E7"
        cyan = "#94E2D5"
        white = "#BAC2DE"

        [[colors.indexed_colors]]
        index = 16
        color = "#FAB387"

        [[colors.indexed_colors]]
        index = 17
        color = "#F5E0DC"

        [selection]
        save_to_clipboard = true
      '';

      ".config/helix/themes/xaviduds.toml".text = ''
        "attribute" = { fg = "blue", modifiers = ["italic"] }
        "ui.virtual.wrap"="softwrap"
        "keyword" = "keyword"
        "keyword.control.conditional" = { fg = "conditional", modifiers = ["italic"] }
        "keyword.directive" = "magenta" # -- preprocessor comments (#if in C)

        "namespace" = { fg = "namespace", modifiers = ["italic"] }

        "punctuation" = "gray06"
        "punctuation.delimiter" = "gray06"

        "operator" = "white"
        "special" = "yellow"

        "variable" = {fg="fg"}
        "variable.builtin" = "bright_blue"
        "variable.parameter" = {fg="white", modifiers=["italic"]}
        "variable.other.member" = "white"

        "type" = "bright_blue"
        "type.builtin" = "magenta"
        "type.enum.variant" = "magenta"

        "constructor" = "yellow"

        "function" = {fg="function", modifiers=["italic"]}
        "function.macro" = "bright_cyan"
        "function.builtin" = "support_function"

        "tag" = "tag"
        "comment" = { fg = "comment", modifiers = ["italic"] }

        "string" = "string"
        "string.regexp" = "green"
        "string.special" = "yellow"

        "constant" = "constant"
        "constant.builtin" = "yellow"
        "constant.numeric" = "numeric"
        "constant.character.escape" = "cyan"

        # used for lifetimes
        "label" = "yellow"

        "markup.heading.marker" = { fg = "gray06" }
        "markup.heading" = { fg = "bright_blue", modifiers = ["bold"] }
        "markup.list" = "gray06"
        "markup.bold" = { modifiers = ["bold"] }
        "markup.italic" = { modifiers = ["italic"] }
        "markup.link.url" = { fg = "green", modifiers = ["underlined"] }
        "markup.link.text" = { fg = "blue", modifiers = ["italic"] }
        "markup.raw" = "yellow"

        "diff.plus" = "bright_green"
        "diff.minus" = "red"
        "diff.delta" = "bright_blue"

        "ui.background" = { bg = "bg" }
        "ui.background.separator" = { fg = "fg" }

        "ui.linenr" = { fg = "gray04" }
        "ui.linenr.selected" = { fg = "fg" }

        "ui.statusline" = { fg = "status_line_fg", bg = "gray01" }
        "ui.statusline.inactive" = { fg = "fg", bg = "gray01", modifiers = ["dim"] }
        "ui.statusline.normal" = { fg = "bg", bg = "cyan", modifiers = ["bold"] }
        "ui.statusline.insert" = { fg = "bg", bg = "blue", modifiers = ["bold"] }
        "ui.statusline.select" = { fg = "bg", bg = "magenta", modifiers = ["bold"] }

        "ui.popup" = { bg = "gray01" }
        "ui.window" = { fg = "gray02" }
        "ui.help" = { bg = "gray01", fg = "white" }

        "ui.text" = { fg = "fg" }
        "ui.text.focus" = { fg = "fg" }

        "ui.virtual" = { fg = "gray02" }
        "ui.virtual.ruler" = {bg="gray02"}
        "ui.virtual.indent-guide" = { fg = "gray02" }
        "ui.virtual.inlay-hint" = { fg = "gray03" }


        "ui.selection" = { bg = "gray03" }
        "ui.selection.primary" = { bg = "gray03" }

        "ui.cursor" = {fg="bg", bg = "cursor" }
        "ui.cursor.match" = { fg = "yellow", modifiers = ["bold", "underlined"] }
        "ui.cursorline.primary" = { bg = "gray01" }

        "ui.highlight" = { bg = "gray02" }

        "ui.menu" = { fg = "white", bg = "gray01" }
        "ui.menu.selected" = { fg = "bright_white", bg = "gray03" }
        "ui.menu.scroll" = { fg = "gray04", bg = "gray01" }

        diagnostic = { modifiers = ["underlined"] }
        "diagnostic.unnecessary" = { modifiers = ["dim"] }
        "diagnostic.deprecated" = { modifiers = ["crossed_out"] }

        warning = "yellow"
        error = "error"
        info = "bright_blue"
        hint = "bright_cyan"

        [palette]
        error="#fca5a5"
        bg = "#0F1014"
        fg = "#c9c7cd"
        green = "#90b99f"
        bright_green = "#9dc6ac"
        yellow = "#e5c890"
        blue = "#aca1cf"
        bright_blue = "#b9aeda"
        magenta = "#e29eca"
        cyan = "#ea83a5"
        bright_cyan = "#f591b2"
        white = "#c1c0d4"
        bright_white = "#cac9dd"
        gray01 = "#1b1b1d"
        gray02 = "#2a2a2d"
        gray03 = "#3e3e43"
        gray04 = "#57575f"
        gray06 = "#9998a8"
        gray07 = "#c1c0d4"
        comment="#808080"
        red="#e78284"
        function="#e5c890"
        support_function="#9898a6"
        constant="#8eb6f5"
        string="#9898a6"
        tag="#9898a6"
        keyword="#8eb6f5"
        namespace= "#c58fff"
        numeric= "#e9c46a"
        status_line_fg = "#e5c890"
        operator="#8eb6f5"
        softwrap="#808080"
        conditional="#a8a29e"
        cursor="#e5c890"
      '';
      ".config/rofi/config.rasi".text = ''
        @theme "/dev/null"

        configuration {
            modi: "drun";
            icon-theme: "Oranchelo";
            show-icons: true;
            terminal: "wezterm";
            drun-display-format: "{icon} {name}";
            location: 0;
            disable-history: false;
            hide-scrollbar: true;
            display-drun: "";
            sidebar-mode: true;
        }

          * {
            bg-col:  #1e1e2e;
            bg-col-light: #1e1e2e;
            border-col: #1e1e2e;
            selected-col: #1e1e2e;
            blue: #89b4fa;
            fg-col: #cdd6f4;
            fg-col2: #f38ba8;
            grey: #6c7086;

            width: 600;
            font: "JetBrainsMono Nerd Font 14";
        }

        element-text, element-icon , mode-switcher {
            background-color: inherit;
            text-color:       inherit;
        }

        window {
            height: 360px;
            border: 3px;
            border-color: @border-col;
            background-color: @bg-col;
        }

        mainbox {
            background-color: @bg-col;
        }

        inputbar {
            children: [prompt,entry];
            background-color: @bg-col;
            border-radius: 5px;
            padding: 2px;
        }

        prompt {
            background-color: @blue;
            padding: 6px;
            text-color: @bg-col;
            border-radius: 3px;
            margin: 20px 0px 0px 20px;
        }

        textbox-prompt-colon {
            expand: false;
            str: ":";
        }

        entry {
            padding: 6px;
            margin: 20px 0px 0px 10px;
            text-color: @fg-col;
            background-color: @bg-col;
        }

        listview {
            border: 0px 0px 0px;
            padding: 6px 0px 0px;
            margin: 10px 0px 0px 20px;
            columns: 2;
            lines: 5;
            background-color: @bg-col;
        }

        element {
            padding: 5px;
            background-color: @bg-col;
            text-color: @fg-col  ;
        }

        element-icon {
            size: 25px;
        }

        element selected {
            background-color:  @selected-col ;
            text-color: @fg-col2  ;
        }

        mode-switcher {
            spacing: 0;
          }

        button {
            padding: 10px;
            background-color: @bg-col-light;
            text-color: @grey;
            vertical-align: 0.5; 
            horizontal-align: 0.5;
        }

        button selected {
          background-color: @bg-col;
          text-color: @blue;
        }

        message {
            background-color: @bg-col-light;
            margin: 2px;
            padding: 2px;
            border-radius: 5px;
        }

        textbox {
            padding: 6px;
            margin: 20px 0px 0px 20px;
            text-color: @blue;
            background-color: @bg-col-light;
        }
      '';
      ".config/wlogout/layout".text = ''
        {
            "label" : "logout",
            "action" : "hyprctl dispatch exit 0",
            "text" : "Logout",
            "keybind" : "e"
        }

        {
            "label" : "suspend",
            "action" : "systemctl suspend",
            "text" : "Suspend",
            "keybind" : "u"
        }

        {
            "label" : "shutdown",
            "action" : "systemctl poweroff",
            "text" : "Shutdown",
            "keybind" : "p"
        }

        {
            "label" : "reboot",
            "action" : "systemctl reboot",
            "text" : "Reboot",
            "keybind" : "r"
        }
      '';
      ".config/wlogout/style.css".text = ''
        * {
          font-family: 'CaskaydiaCove NFM', monospace;
          background-image: none;
          transition: 20ms;
        }

        window {
          background-color: rgba(12, 12, 12, 0.1);
        }

        button {
          color: #FFFFFF;
          font-size: 20px;

          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          transition: background-size 300ms ease-in-out;

          border-style: solid;
          border-width: 3px;
          border-color: #FFFFFF;
          border-radius: 20px;

          margin: 10px;
          box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        button:hover,
        button:active {
          color: @color11;
          background-color: rgba(12, 12, 12, 0.5);
          border-color: @color11;
          background-size: 30%;
        }

        #logout {
          text: "(L)ogout";
        }

        #suspend {
        text: "s(U)spend";
        }

        #shutdown {
        text: "(S)hutdown";
        }

        #reboot {
        text: "(R)eboot";
        }
      '';
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
        nix_shell = {
          disabled = false;
          impure_msg = "[impure shell](bold red)";
          pure_msg = "[pure shell](bold green)";
          unknown_msg = "[unknown shell](bold yellow)";
          format = "via [☃️ $state( ($name))](bold blue) ";
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

    waybar = {
      enable = true;
      systemd.enable = true;
      style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;
        * {
          /* reference the color by using @color-name */
          color: @text;
        }

        window#waybar {
          /* you can also GTK3 CSS functions! */
          background-color: shade(@base, 0.9);
          border: 2px solid alpha(@crust, 0.3);
        }      
      '';
      settings = [{
        height = 30;
        layer = "top";
        position = "top";
        modules-left = [ "privacy" ];
        modules-center = [ "hyprland" ];
        modules-right = [ "wireplumber" "cpu" "memory" "clock" "battery" ];
        battery = {
          format = "{capacity}%";
          format-alt = "{time}";
        };
        clock = { format = "{:%H:%M %d-%m-%Y}"; };
        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "";
          on-click = "helvum";
          format-icons = [ "" "" "" ];
        };
      }];
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
        "SUPER, ESCAPE, exec, wlogout"
        "SUPER, Q, exec, alacritty"
        "SUPER, P, exec, pavucontrol"
        "SUPER, S, exec, stremio"
        "SUPER, F, exec, firefox"
        "SUPER, O, exec, obsidian"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, R, exec, rofi -show drun -show-icons -terminal alacritty -scroll-method 1 -click-to-exit"
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
