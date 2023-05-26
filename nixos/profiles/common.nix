{ settings }:
{ config, pkgs, ... }: {
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ../files/xmonad.hs;
      enableContribAndExtras = true;
    };
  };

  services.status-notifier-watcher.enable = true;
  services.taffybar = {
    enable = true;
  };
  services.xscreensaver.enable = true;

  xresources = {
    properties = {
      "xterm*faceName" = "DejaVu Sans Mono for Powerline:size=12:antialias=true";
      "URxvt.font" = "xft:DejaVu Sans Mono for Powerline:size=12:antialias=true";
      "URxvt.scrollBar" = "false";
      "Xft.dpi" = settings.dpi;
      "Xft.antialias" = "1";
    };
    extraConfig =
      let
        gruvbox-contrib =
          pkgs.fetchFromGitHub {
            owner = "morhetz";
            repo = "gruvbox-contrib";
            rev = "edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
            sha256 = "0n32s5var4xxwk3bwm70mwja0gy6vaj2awm6kji10yw3fpqgg7yh";
          };
      in
        builtins.readFile (
          "${gruvbox-contrib}/xresources/gruvbox-dark.xresources"
        );
  };

  programs.emacs.enable = true;
  home.file.".emacs.d" = {
    recursive = true;
    source = builtins.fetchGit {
      name = "spacemacs";
      url = https://github.com/syl20bnr/spacemacs/;
      ref = "refs/heads/develop";
      # `git ls-remote https://github.com/syl20bnr/spacemacs develop`
      rev = "6774f37fc1c542fab664f1b65931e52a4991d71a";
    };
  };
  home.file.".emacs.d/private/spacemacs-neuron" = {
    recursive = true;
    source = builtins.fetchGit {
      name = "spacemacs-neuron";
      url = https://github.com/LightAndLight/spacemacs-neuron/;
      ref = "refs/heads/1.9.33.0";
      # `git ls-remote https://github.com/LightAndLight/spacemacs-neuron master`
      rev = "3750b3e7793f50e11ffac3aa0425a56fc279d5ab";
    };
  };
  home.file.".spacemacs" = {
    source = ../files/spacemacs;
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "1eaed8c";
          sha256 = "sha256-whTAO4ZxglCr9vm/WXJItwnVoHZYG3qKh9rYWF5dhaE=";
        };
      }
    ];
    interactiveShellInit = ''
      fish_vi_key_bindings
      set -g theme_color_scheme gruvbox
    '';
  };

  programs.firefox = {
    enable = true;
    profiles.isaac = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
      #TabsToolbar { visibility: collapse; }
      '';
    };
  };

  programs.git = {
    enable = true;
    userName = "Isaac Elliott";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "current";
      };
    };
  };

  programs.helix = {
    enable = true;
    settings.theme = "gruvbox";
    # requires 23.03
    # settings.editor.soft-wrap.enable = true;
    settings.editor.cursor-shape = {
      insert = "bar";
      select = "underline";
    };
    settings.editor.lsp = {
      display-messages = true;
      # requires 23.03
      # display-inlay-hints = true;
    };
  };

  # Without this, Taffybar crashes when launching Alacritty.
  #
  # See:
  #
  # * https://github.com/taffybar/taffybar/issues/332#issuecomment-722998632
  # * https://github.com/taffybar/taffybar/issues/332#issuecomment-723000490
  home.sessionVariables.GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
  programs.alacritty = {
    enable = true;
    settings = {
      draw_bold_text_with_bright_colors = true;

      font = {
        size = 12.0;
        normal.family = "DejaVu Sans Mono for Powerline";
      };

      # Gruvbox Dark
      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xebdbb2";
        };
        normal = {
          black = "0x282828";
          red = "0xcc241d";
          green = "0x98971a";
          yellow = "0xd79921";
          blue = "0x458588";
          magenta = "0xb16286";
          cyan = "0x689d6a";
          white = "0xa89984";
        };
        bright = {
          black = "0x928374";
          red = "0xfb4934";
          green = "0xb8bb26";
          yellow = "0xfabd2f";
          blue = "0x83a598";
          magenta = "0xd3869b";
          cyan = "0x8ec07c";
          white = "0xebdbb2";
        };
      };
    };
  };
}
