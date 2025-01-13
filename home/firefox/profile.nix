{
  settings = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

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
  };
  userChrome = ''
    :root {
      font-size: 16px !important;
    }

    menu, menuitem, toolbarbutton, toolbaritem {
      font-size: 16px;
    }

    #TabsToolbar { visibility: collapse; }

    #sidebar-box {
      min-width: 5rem !important;
    }
  '';
}
