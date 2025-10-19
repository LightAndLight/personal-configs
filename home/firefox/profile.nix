{ osConfig, ...}: {
  settings = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    # Fonts
    "font.size.monospace.x-western" = builtins.ceil osConfig.fonts.size.px;
    "font.size.variable.x-western" = builtins.ceil osConfig.fonts.size.px;

    # Disable built-in ads
    "browser.newtabpage.activity-stream.discoverystream.newSponsoredLabel.enabled" = false;
    "browser.newtabpage.activity-stream.discoverystream.sponsored-collections.enabled" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.system.showSponsored" = false;
    "browser.urlbar.quicksuggest.impressionCaps.sponsoredEnabled" = false;
    "browser.urlbar.quicksuggest.sponsoredIndex" = -1;
    "browser.urlbar.sponsoredTopSites" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

    # Disable search suggestions
    "browser.search.suggest.enabled" = false;

    # Disable unhelpful URL bar entries
    "browser.urlbar.suggest.topsites" = false;
    "browser.urlbar.suggest.trending" = false;
    "browser.urlbar.suggest.weather" = false;
    "browser.urlbar.suggest.yelp" = false;

    # Disable "AI" features
    "browser.ml.enable" = false;
    "browser.ml.chat.enabled" = false;
    "browser.ml.chat.menu" = false;
    "browser.ml.chat.page" = false;
    "extensions.ml.enabled" = false;

    # Better scrollbars
    "widget.gtk.overlay-scrollbars.enabled" = false;
    "widget.non-native-theme.scrollbar.size.override" = builtins.floor (1.0 * osConfig.fonts.size.px);

     # I don't need to see recent searches; most of my searches are one-shot
    "browser.urlbar.suggest.recentsearches" = false;
  };

  userChrome = ''
    #TabsToolbar { visibility: collapse; }

    #sidebar-box {
      min-width: 5rem !important;
    }
  '';

  userContent = ''
    @-moz-document url-prefix("") {
      button, input[type="button"], input[type="submit"], input[type="reset"] {
        font-size: ${builtins.toString osConfig.fonts.size.px}px;
      }
    }
  '';
}
