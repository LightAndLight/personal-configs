{ pkgs, ... }: {
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
}
