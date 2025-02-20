{ pkgs, config, ... }: {
  options = with pkgs.lib; {
    ui = {
      cursor = {
        package = mkOption {
          type = types.package;
          description = "Cursor theme package.";
        };

        themeName = mkOption {
          type = types.str;
          description = "Cursor theme to use. See also: <https://wiki.archlinux.org/title/Cursor_themes>";
        };

        size = mkOption {
          type = types.int;
          description = "Cursor size, in points.";
        };
      };
    };
  };

  config = {
    environment.systemPackages = [ config.ui.cursor.package ];
  };
}
