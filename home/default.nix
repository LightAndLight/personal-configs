{
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./ssh.nix
    ./taffybar
    ./xresources.nix
    ./xsession
  ];
  
  services.xscreensaver.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "22.11";
}
