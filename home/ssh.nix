{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        # Defaults
        #
        # I object to needing to set these. I've used SSH for 10 years and I've
        # never seen these options. Therefore, they're not important for typical
        # use.
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";

        ControlPersist = "60m";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/%u@%l-%r@%h:%p.sock";
      };
      "github.com" = {
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        PreferredAuthentications = "publickey";
      };
    };
  }; 
}
