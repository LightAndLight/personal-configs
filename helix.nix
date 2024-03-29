{ ... }: {
  programs.helix = {
    enable = true;
    settings.theme = "gruvbox";
    # requires 23.03
    # settings.editor.soft-wrap.enable = true;
    settings.editor.cursor-shape = {
      insert = "bar";
      select = "underline";
    };
    settings.editor.file-picker.hidden = false;
    # requires 23.03?
    # settings.editor.text-width = 100;
    settings.editor.lsp = {
      display-messages = true;
      # requires 23.03
      # display-inlay-hints = true;
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
