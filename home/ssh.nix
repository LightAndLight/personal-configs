{ config, ... }:
{
  programs.ssh = {
    enable = true;
    controlPersist = "60m";
    controlMaster = "auto";
    controlPath = "~/.ssh/%u@%l-%r@%h:%p.sock";
    matchBlocks."github.com" = {
      identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
      extraOptions.PreferredAuthentications = "publickey";
    };
  }; 
}
