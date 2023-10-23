{ pkgs, lib, inputs, ... }:

let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  nixpkgs.config.allowUnfree = true;
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles.ooks = {
      bookmarks = { };
      extensions = with addons; [
        ublock-origin
        browserpass
        stylus
        surfingkeys
      ];
      settings = {
        
        #Basic Settings
        "browser.disableResetPrompt" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.memory.capacity" = 524288;
        "browser.sessionstore.interval" = 15000000;
        "extensions.pocket.enabled" = false;
        "reader.parse-on-load.enabled" = false;
        "accessibility.force_disabled" = 1;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        
        #Startup
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.aboutConfig.showWarning" = false;
        
        #Disable recommendations
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        
        #Telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true; 
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
        "browser.vpn_promo.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        
        #Crash Reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        
        #Other
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        
        #Geolocation
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        "geo.provider.use_gpsd" = false;
        "geo.provider.use_geoclue" = false;
        
        #Calculator
        "browser.urlbar.suggest.calculator" = true;
      };

      userChrome =
        ''
        /* config */

        * {
          --animation-speed: 0.2s;
          --button-corner-rounding: 30px;
          --urlbar-container-height: 40px !important;
          --urlbar-min-height: 30px !important;
          --urlbar-height: 30px !important;
          --urlbar-toolbar-height: 38px !important;
          --moz-hidden-unscrollable: scroll !important;
          --toolbarbutton-border-radius: 3px !important;
          --tabs-border-color: transparent;
        }

        :root {
            --window: -moz-Dialog !important;
            --secondary: color-mix(in srgb, currentColor 5%, -moz-Dialog) !important;
            --uc-border-radius: 0px;
            --uc-status-panel-spacing: 0px;
            --uc-page-action-margin: 7px;
        }

        /* animation and effect */
        #nav-bar:not([customizing]) {
          visibility: visible;
          margin-top: -40px;
          transition-delay: 0.1s;
          filter: alpha(opacity=0);
          opacity: 0;
          transition: visibility, ease 0.1s, margin-top, ease 0.1s, opacity, ease 0.1s,
          rotate, ease 0.1s !important;
        }

        #nav-bar:hover,
        #nav-bar:focus-within,
        #urlbar[focused='true'],
        #identity-box[open='true'],
        #titlebar:hover + #nav-bar:not([customizing]),
        #toolbar-menubar:not([inactive='true']) ~ #nav-bar:not([customizing]) {
          visibility: visible;

          margin-top: 0px;
          filter: alpha(opacity=100);
          opacity: 100;
          margin-bottom: -0.2px;
        }
        #PersonalToolbar {
          margin-top: 0px;
        }
        #nav-bar .toolbarbutton-1[open='true'] {
          visibility: visible;
          opacity: 100;
        }

        tab:not(:active) .tab-background {
          transition: background-color var(--animation-speed) !important;
        }
        :root:not([customizing]) :hover > .tabbrowser-tab:not(:hover) {
          transition: blur, ease 0.1s !important;
        }

        :root:not([customizing]) :not(:hover) > .tabbrowser-tab {
          transition: blur, ease 0.1s !important;
        }

        #tabbrowser-tabs .tab-label-container[customizing] {
          color: transparent;
          transition: ease 0.1s;
          transition-delay: 0.2s;
        }

        .tabbrowser-tab:not([pinned]) .tab-icon-image ,.bookmark-item .toolbarbutton-icon{opacity: 0!important; transition: .15s !important; width: 0!important; padding-left: 16px!important}
        .tabbrowser-tab:not([pinned]):hover .tab-icon-image,.bookmark-item:hover .toolbarbutton-icon{opacity: 100!important; transition: .15s !important; display: inline-block!important; width: 16px!important; padding-left: 0!important}
        .tabbrowser-tab:not([hover]) .tab-icon-image,.bookmark-item:not([hover]) .toolbarbutton-icon{padding-left: 0!important}

        /*  Removes annoying buttons and spaces */
        #firefox-view-button, .titlebar-spacer[type="pre-tabs"], .titlebar-spacer[type="post-tabs"]{display: none !important}
        #tabbrowser-tabs{border-inline-start-width: 0!important}

        /*  Makes some buttons nicer  */
        #PanelUI-menu-button, #unified-extensions-button, #reload-button, #stop-button {padding: 2px !important}
        #reload-button, #stop-button{margin: 1px !important;}

        /* Tabs colors  */
        #tabbrowser-tabs:not([movingtab])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab
          > .tab-stack
          > .tab-background[multiselected='true'],
        #tabbrowser-tabs:not([movingtab])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab
          > .tab-stack
          > .tab-background[selected='true'] {
          background-image: none !important;
          background-color: var(--toolbar-bgcolor) !important;
        }

        /* Inactive tabs color */
        #navigator-toolbox {
          background-color: var(--window) !important;
        }

        /* X-button */
        :root {
            --show-tab-close-button: none;
            --show-tab-close-button-hover: -moz-inline-block;
        }
        .tabbrowser-tab:not([pinned]) .tab-close-button { display: var(--show-tab-close-button) !important; }
        .tabbrowser-tab:not([pinned]):hover .tab-close-button { display: var(--show-tab-close-button-hover) !important }

        /* Window colors  */

        :root {
          --lwt-sidebar-background-color: var(--window) !important;
          --lwt-toolbar-field-focus: var(--secondary) !important;
        }

        /* tabbar */

        /* Hide the secondary Tab Label
         * e.g. playing indicator (the text, not the icon) */
        .tab-secondary-label { display: none !important; }

        #nav-bar:not([tabs-hidden='true']) {
          box-shadow: none;
        }

        :root {
          --toolbarbutton-border-radius: 0 !important;
          --tab-border-radius: 0 !important;
          --tab-block-margin: 0 !important;
        }

        .tab-background {
          border-right: 0px solid rgba(0, 0, 0, 0) !important;
          margin-left: -4px !important;
        }

        .tabbrowser-tab:is([visuallyselected='true'], [multiselected])
          > .tab-stack
          > .tab-background {
          box-shadow: none !important;
        }

        .tabbrowser-tab[last-visible-tab='true'] {
          padding-inline-end: 0 !important;
        }

        #tabs-newtab-button {
          padding-left: 0 !important;
        }

        /* remove tab shadow */
        .tabbrowser-tab
          >.tab-stack
          > .tab-background { box-shadow: none !important;  }

        /* multi tab selection */
        #tabbrowser-tabs:not([noshadowfortests]) .tabbrowser-tab:is([multiselected])
          > .tab-stack
          > .tab-background:-moz-lwtheme { outline-color: var(--toolbarseparator-color) !important; }

        /* Hides the list-all-tabs button*/
        #alltabs-button { display: var(--uc-show-all-tabs-button) !important; }

        /* remove gap after pinned tabs */
        #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
          > #tabbrowser-arrowscrollbox
          > .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) { margin-inline-start: 0 !important; }

        /*  Removes annoying border  */
        #navigator-toolbox{border:none !important;}

        /*  Removes the annoying rainbow thing from the hamburger  */
        #appMenu-fxa-separator{border-image:none !important;}
        '';
      userContent = ''
        @-moz-document url-prefix(about:){

        /*  Removes the scrollbar on some places  */
        body,html{overflow-y: auto}

        /*  Devtools  */
        @-moz-document url-prefix(about:devtools){
        #toolbox-container{margin-top: 10px !important}
        .devtools-tabbar{background: transparent !important}
        .devtools-tab-line{border-radius: 0 0 5px 5px}
        .customize-animate-enter-done,.customize-menu,.top-site-outer:hover,button{background-color: transparent!important}}

        /*  Newtab  */
        @-moz-document url("about:home"), url("about:newtab"){
        .search-wrapper .search-handoff-button .fake-caret {top: 13px !important; inset-inline-start: 48px !important}
        .search-wrapper .logo-and-wordmark{opacity: 0.9 !important; order: 1 !important; margin-bottom: 0 !important; flex: 1 !important; flex-basis: 20% !important}
        .search-wrapper .search-handoff-button .fake-caret{top: 13px !important; inset-inline-start: 48px !important}
        .search-wrapper .logo-and-wordmark{opacity: 0.9 !important; order: 1 !important; margin-bottom: 0 !important; flex: 1 !important; flex-basis: 20% !important}
        .outer-wrapper .search-wrapper{padding: 0px !important; display: flex !important; flex-direction: row !important; flex-wrap: wrap !important; justify-content: center !important; align-items: center !important; align-content: space-around !important; gap: 20px 10px !important}
        .search-wrapper .logo-and-wordmark .logo{background-size: 60px !important; height: 60px !important; width: 60px !important}
        .search-wrapper .search-inner-wrapper{min-height: 42px !important; order: 2 !important; flex: 3 !important; flex-basis: 60% !important; top: 4px !important}
        .search-wrapper .search-inner-wrapper{min-height: 42px !important; order: 2 !important; flex: 3 !important; flex-basis: 60% !important; top: 4px !important}
        .outer-wrapper.ds-outer-wrapper-breakpoint-override.only-search.visible-logo{display: flex !important; padding-top: 0px !important;vertical-align: middle}
        .customize-menu{border-radius: 10px 0 0 10px !important}
        #root > div{align-items: center; display: flex}}}
      '';
    };
  };

  home = {
    sessionVariables = {
      # https://github.com/NixOS/nixpkgs/issues/238025
      TZ = "/etc/localtime";
      BROWSER = "firefox";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
