{
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
    source = ./spacemacs;
  };
}
