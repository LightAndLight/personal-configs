{
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./xsession
    ./emacs
    ./xresources.nix
    ./taffybar.nix
    ./alacritty.nix
    ./firefox.nix
    ./ssh.nix
  ];
  
  services.xscreensaver.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "22.11";
}
