{
  imports = if builtins.pathExists ./private-ssh.nix then [ ./private-ssh.nix ] else [];
}
