{
  virtualisation.docker.enable = false;

  virtualisation.virtualbox.host.enable = false;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
}
