{
  services.syncthing.enable = true;

  # Allow reading by `syncthing` group members
  users.users.syncthing.homeMode = "770";

  # Grant explicit access to the `syncthing` user and `syncthing` group members.
  #
  # ## Motivation
  #
  # I sync a KeePassXC database from my desktop to other devices. When I edit the database,
  # KeePassXC sets the user, group, and permissions to the defaults for the account that
  # I was using. This denies access to the `syncthing` user. Also, I use separate work
  # and personal accounts on the same machine. If I edit the database from one account
  # then change to the other then the second account will be denied access.
  #
  # I work around this by having all my accounts in the `syncthing` group, and granting
  # explicit access to `syncthing` group members.
  systemd.tmpfiles.rules = [
    "A /var/lib/syncthing/sync - - - - u:syncthing:rwX,d:u:syncthing:rwX,g:syncthing:rwX,d:g:syncthing:rwX"
  ];
}
