{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
      extraPolicies = {
        DisplayBookmarksToolbar = true;
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
