{ config, pkgs, lib, ... }:
{
  services.status-notifier-watcher.enable = true;
  services.taffybar.enable = true;

  home.file.".config/taffybar/taffybar.css".source = ./taffybar.css;
  
  # Without this, Taffybar crashes when launching Alacritty.
  #
  # See:
  #
  # * https://github.com/taffybar/taffybar/issues/332#issuecomment-722998632
  # * https://github.com/taffybar/taffybar/issues/332#issuecomment-723000490
  home.sessionVariables.GDK_PIXBUF_MODULE_FILE =
    lib.mkIf
      config.programs.alacritty.enable
      "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
}
