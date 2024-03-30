{ ... }: {
  programs.helix = {
    enable = true;
    settings.theme = "gruvbox";
    settings.editor = {
      soft-wrap = {
        enable = true;
        max-wrap = 0;
      };
      cursor-shape = {
        insert = "bar";
        select = "underline";
      };
      file-picker.hidden = false;
      text-width = 100;
      lsp.display-messages = true;
    };
    settings.keys = {
      select = {
        "$" = "extend_to_line_end";
        "^" = "extend_to_line_start";
      };
    };
    languages = {
      language-server.rust-analyzer = {
        config.check.command = "clippy";
      };
    };
  };
}
