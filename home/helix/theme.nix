# This theme is inspired by <https://tonsky.me/blog/syntax-highlighting/>
#
# Keywords, punctuation, and operators are de-emphasised in gray.
# Comments are highlighted in blue, and data literals are highlighted in cyan.
#
# Blue, yellow, and red are used for info, warning, and error messages respectively.
let name = "minimal"; in
{
  programs.helix = {
    settings.theme = name;
    themes.${name} = {
      inherits = "gruvbox_dark_soft";

      "diagnostic.hint" = { fg = "light-blue"; underline.style = "line"; };
      "hint" = { fg = "light-blue"; };

      "diagnostic.info" = { fg = "light-blue"; underline.style = "line"; };
      "info" = { fg = "light-blue"; };

      "diagnostic.warning" = { fg = "light-yellow"; underline.style = "line"; };
      "warning" = { fg = "light-yellow"; };

      "diagnostic.error" = { fg = "light-red"; underline.style = "line"; };
      "error" = { fg = "light-red"; };

      "ui.linenr.selected" = { fg = "white"; };

      "diff.plus.gutter" = { fg = "light-green"; };
      "diff.minus.gutter" = { fg = "light-red"; };
      "diff.delta.gutter" = { fg = "light-green"; };

      comment = { fg = "light-blue"; };

      "comment.unused" = { fg = "gray"; };
      keyword = { fg = "gray"; };
      operator = { fg = "gray"; };
      punctuation = { fg = "gray"; };

      constant = { fg = "light-cyan"; };
      constructor = { fg = "light-cyan"; };
      "constant.character.escape" = { fg = "light-cyan"; };
      label = { fg = "light-cyan"; };
      string = { fg = "light-cyan"; };
      "string.special" = { fg = "inherit"; };

      function = { fg = "inherit"; };
      "function.builtin" = { fg = "inherit"; };
      tag = { fg = "inherit"; };
      type = { fg = "inherit"; };
      "variable.other.member" = { fg = "inherit"; };
      "variable.parameter" = { fg = "inherit"; };

      "markup.heading" = "inherit";
      "markup.link.text" = "inherit";
      "markup.link.url" = { fg = "inherit"; modifiers = ["underlined"]; };
      "markup.raw" = "inherit";
    };
  };
}
