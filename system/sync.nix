{ config, inputs, pkgs, ... }:
let
  syncthingApiKeyFile = "/run/secrets/syncthing-api-key";
in
{
  imports = [
    inputs.asker.nixosModules.nixos
    inputs.sops-nix.nixosModules.sops
    inputs.syncthing-merge.nixosModules.default
  ];

  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    settings.folders = {
      sync = {
        id = "pkf7r-yzgxs";
        type = "sendreceive";
        path = "${config.services.syncthing.dataDir}/sync";
      };
    };
  };

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
    "A /var/lib/syncthing - - - - u:syncthing:rwX,d:u:syncthing:rwX,g:syncthing:rwX,d:g:syncthing:rwX"
  ];

  sops.secrets.syncthing-api-key = {
    sopsFile = ./sync/api-key.txt.secret;
    format = "binary";

    mode = "0440";
    owner = config.services.syncthing.user;
    group = config.services.syncthing.group;
    restartUnits = ["syncthing.service" "syncthing-merge.service"];
  };

  services.asker = {
    enable = true;
    keys = {
      keepassxc.description = "your KeepassXC password";
    };
  };

  services.syncthing-merge = {
    enable = true;
    extraGroups = [ config.services.asker.keys.keepassxc.group ];
    settings = {
      syncthingUrl = "http://sync.local";
      inherit syncthingApiKeyFile;
      mergeTargets = [
        {
          folderId = "pkf7r-yzgxs";
          folderName = "sync";
          files = [
            {
              name = "passwords.kdbx";
              program = pkgs.writeScript "syncthing-merge-keepassxc" ''
                #! ${pkgs.bash}/bin/bash
                set -euo pipefail
                ${pkgs.asker}/bin/asker keepassxc | ${pkgs.keepassxc}/bin/keepassxc-cli merge --same-credentials "$2" "$1"
                mv "$2" "$1"
              '';
            }
            {
              name = "database.tsk";
              program = pkgs.writeScript "syncthing-merge-tsk" ''
                #! ${pkgs.bash}/bin/bash
                set -eu
                ${pkgs.tsk}/bin/tsk -d "$2" merge "$1"
                mv "$2" "$1"
              '';
            }
          ];
        }
      ];
    };
  };

  systemd.services.syncthing.serviceConfig.ExecStartPre =
    let
      syncthingConfig = "${config.services.syncthing.configDir}/config.xml";
    in
      pkgs.writeScript "syncthing-set-key" ''
        #! ${pkgs.python3}/bin/python3

        import os
        import re

        secret_path = "${syncthingApiKeyFile}"
        print(f"Setting Syncthing API key from {secret_path}")

        old_path = "${syncthingConfig}"
        new_path = f"{old_path}.new"

        with open(old_path, 'r') as old_file:
          content = old_file.read()
          with open(secret_path, 'r') as secret_file:
            new_content = re.sub('<apikey>.*</apikey>', f'<apikey>{secret_file.read().strip()}</apikey>', content)

        with open(new_path, 'w') as new_file:
          new_file.write(new_content)

        os.rename(new_path, old_path)
      '';

  services.nginx = {
    enable = true;
    virtualHosts."sync.local" = {
      listen = [ { addr = "sync.local"; port = 80; } ];
      locations."/".proxyPass = "http://${config.services.syncthing.guiAddress}";
    };
  };

  networking.hosts = {
    "127.0.0.1" = [ "sync.local" ];
  };
}
