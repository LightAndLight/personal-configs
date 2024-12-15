{ config, inputs, system, ... }: {
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    projectRoot = ../.;
    settings = config.settings;
    inherit
      system
      inputs
    ;
  };
}
