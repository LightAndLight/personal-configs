{ config, pkgs, lib, ... }:
let
  awsVaultConfig = config.aws-vault;
in
{
  options = {
    aws-vault = {
      iamUser = lib.mkOption {
        type = lib.types.str;
        description = "The IAM user to authenticate as.";
      };

      region = lib.mkOption {
        type = lib.types.str;
        description = "The region in which to authenticate.";
      };

      mfaSerial = lib.mkOption {
        type = lib.types.str;
        description = "Serial number of the user's assigned MFA device.";
      };

      promptMethod = lib.mkOption {
        type = lib.types.enum [ "zenity" ];
        description = "Prompt dialog type for MFA input.";
      };
    };
  };

  config = {
    home.packages = with pkgs; [
      # `aws-vault` is used to provide MFA access to `aws` CLI commands.
      aws-vault
    ] ++
    (if awsVaultConfig.promptMethod == "zenity"
      # `zenity` allows `aws-vault` to open graphical dialog for MFA code entry.
      #
      # `zenity` requires access to the GNOME Keyring. I wasn't able to get Home Manager
      # to install GNOME Keyring, so you need to install it separately.
      #
      # On NixOS, add `services.gnome.gnome-keyring.enable = true;` to your `configuration.nix`.
      then [ gnome.zenity ]
      else []
    );

    home.file.".aws/config" = {
      recursive = true;
      text = ''
        [default]
        region = ${awsVaultConfig.region}
        credential_process = aws-vault exec ${awsVaultConfig.iamUser} --duration=8h --json --prompt=${awsVaultConfig.promptMethod}

        [profile ${awsVaultConfig.iamUser}]
        mfa_serial = ${awsVaultConfig.mfaSerial}
        region = ${awsVaultConfig.region}
      '';
    };

    programs.git = {
      extraConfig = {
        credential."https://git-codecommit.*.amazonaws.com" = {
          helper = "!${pkgs.awscli2}/bin/aws codecommit credential-helper $@";
          UseHttpPath = true;
        };
      };
    };
  };
}
