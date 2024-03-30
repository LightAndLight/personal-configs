{
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./ssh.nix
    ./taffybar.nix
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
