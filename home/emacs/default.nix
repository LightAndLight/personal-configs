{ inputs, ... }:
{
  programs.emacs.enable = true;
  
  home.file.".emacs.d" = {
    recursive = true;
    source = inputs.spacemacs;
  };
  
  home.file.".emacs.d/private/spacemacs-neuron" = {
    recursive = true;
    source = inputs.spacemacs-neuron;
  };
  
  home.file.".spacemacs" = {
    source = ./spacemacs;
  };
}
