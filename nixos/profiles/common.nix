{ settings }:
{ config, pkgs, ... }: {
  nixpkgs.overlays = import ../overlays.nix;

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ../files/xmonad.hs;
      enableContribAndExtras = true;
      extraPackages = pkgs: [ pkgs.taffybar ];
    };
  };

  services.status-notifier-watcher.enable = true;
  services.taffybar = {
    enable = true;
  };
  services.xscreensaver.enable = true;

  xresources = {
    properties = {
      "xterm*faceName" = "DejaVu Sans Mono:size=12:antialias=true";
      "URxvt.font" = "xft:DejaVu Sans Mono:size=12:antialias=true";
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
    interactiveShellInit = ''
      fish_vi_key_bindings
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
}
