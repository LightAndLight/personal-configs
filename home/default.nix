{
  imports = [
    ./alacritty.nix
    ./emacs
    ./email.nix
    ./firefox
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./input.nix
    ./keepassxc.nix
    ./polybar
    ./ssh.nix
    ./ui.nix
    ./xresources.nix
    ./xsession
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "22.11";
}
