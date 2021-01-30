///////////////////
//// INTERFACE ////
///////////////////

// disable about:config warning
user_pref("general.warnOnAboutConfig", false);
user_pref("browser.aboutConfig.showWarning", false);

// disable default browser check
user_pref("browser.shell.checkDefaultBrowser", false);

// don't warn on tab close
user_pref("browser.tabs.warnOnClose", false);

// start session with blank page
 user_pref("browser.startup.page", 0);
// home page blank
user_pref("browser.startup.homepage", "about:blank");
// new tab blank
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload", false);

// firefox's "smart" new tab bookmark bar visibility doesn't
// work with empty newtab pages - workaround in userChrome.css
user_pref("browser.toolbars.bookmarks.visibility", "always");

// disable aggressive url bar suggestions
user_pref("browser.urlbar.maxRichResults", 0);

// enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// layout cusomization
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"urlbar-container\",\"downloads-button\",\"developer-button\",\"fxa-toolbar-menu-button\",\"ublock0_raymondhill_net-browser-action\",\"umatrix_raymondhill_net-browser-action\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"umatrix_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"TabsToolbar\",\"PersonalToolbar\",\"widget-overflow-fixed-list\"],\"currentVersion\":16,\"newElementCount\":17}");
user_pref("browser.uidensity", 1);
user_pref("browser.uitour.enabled", false);

// enable pinch to zoom
user_pref("apz.allow_zooming", true);

// disable delete button going back
user_pref("browser.backspace_action", 2);

// display all parts of url in location bar
user_pref("browser.urlbar.trimURLs", false);

///////////////////////////////
//// DISABLE ANTI-FEATURES ////
///////////////////////////////

// disable what's new panel
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);

// disable pocket
user_pref("extensions.pocket.enabled", false);

// disable firefox accounts
user_pref("identity.fxaccounts.enabled", false);

// disable form autofill
user_pref("browser.formfill.enable", false);
user_pref("signon.autofillForms", false);
user_pref("signon.formlessCapture.enabled", false);
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);

// disable page thumbnail collection
user_pref("browser.pagethumbnails.capturing_disabled", true);

// disable print header/footer
user_pref("print.print_footerleft", "");
user_pref("print.print_footerright", "");
user_pref("print.print_headerleft", "");
user_pref("print.print_headerright", "");

///////////////////////////////////
//// BROWSING SECURITY/PRIVACY ////
///////////////////////////////////

// use mozilla geolocation (not google)
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
// disable OS geolocation
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX]
// disable geo specific search engines
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.geoSpecificDefaults.url", "");

// don't send reports
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("extensions.webcompat-reporter.enabled", false);

// disable feature tests
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// disable recommendations
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// disable telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.ping-centre.telemetry", false);
user_pref("beacon.enabled", false);

// disable captive portal detection
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);


// disable network connectivity checks
user_pref("network.connectivity-service.enabled", false);

// disable uploading screenshots
user_pref("extensions.screenshots.upload-disabled", true);

// disable prefetching
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.http.speculative-parallel-limit", 0);

// disable hyperlink auditing (click tracking)
user_pref("browser.send_pings", false);
user_pref("browser.send_pings.require_same_host", true);

// disable location bar domain guessing on failed lookup (DNS requet modification)
user_pref("browser.fixup.alternate.enabled", false);

// disable location bar suggesting preloaded top sites
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);

// disable location bar speculative connections
user_pref("browser.urlbar.speculativeConnect.enabled", false);

// disable saving passwords
user_pref("signon.rememberSignons", false);

// encryption
// block connections to SSL servers that don't support RFC 5746
user_pref("security.ssl.require_safe_negotiation", true);
// display warning on the padlock for unsafe negotiation
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
// disable SSL session tracking
user_pref("security.ssl.disable_session_identifiers", true);
// disable SSL error reporting
user_pref("security.ssl.errorReporting.automatic", false);
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.errorReporting.url", "");
// disable TLS1.3 0-RTT
user_pref("security.tls.enable_0rtt_data", false);
// set OCSP (certificate validation/revocation) failures to hard-fail
user_pref("security.OCSP.require", true);
// block mixed content on HTTPS pages
user_pref("security.mixed_content.block_active_content", true);
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.mixed_content.block_object_subrequest", true);
// display advanced info on insecure connection warning
user_pref("browser.xul.error_pages.expert_bad_cert", true);

// prevent websites from messing with windows
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.location", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true);
user_pref("dom.disable_window_open_feature.resizable", true);
user_pref("dom.disable_window_open_feature.status", true);
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
user_pref("dom.disable_window_move_resize", true);
user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.restriction", 0);
user_pref("dom.disable_open_during_load", true);
user_pref("dom.popup_allowed_events", "click dblclick");

// enable do not track
user_pref("privacy.donottrackheader.enabled", true);

// disable push notifications via mozilla server
user_pref("dom.push.enabled", false);

// remove temporary files opened with external application
user_pref("browser.helperApps.deleteTempFileOnExit", true);

// disable features that allow for messing with firefox chrome
user_pref("browser.uitour.enabled", false);
user_pref("browser.uitour.url", "");
user_pref("devtools.chrome.enabled", false);
user_pref("devtools.debugger.remote-enabled", false);

// disable middle mouse click opening links from clipboard
user_pref("middlemouse.contentLoadURL", false);

// remove special permissions for mozilla domains
user_pref("permissions.manager.defaultsUrl", "");

// remove webchannel whitelist
user_pref("webchannel.allowObject.urlWhitelist", "");

// show punycode for internationalized domain names
user_pref("network.IDN_show_punycode", true);

// disable permission request delegation from 3rd to 1st parties
user_pref("permissions.delegation.enabled", false);

// disable hiding mime types not associated with a plugin
user_pref("browser.download.hide_plugins_without_extensions", false);

// disable flash
user_pref("plugin.state.flash", 0);

// limit webGL XXX
user_pref("webgl.min_capability_mode", true);

// disable service workers XXX
user_pref("dom.serviceWorkers.enabled", false);

// disable asmjs XXX
user_pref("javascript.options.asmjs", false);

// disable wasm XXX
user_pref("javascript.options.wasm", false);

// prevent accessibility services from accessing the browser XXX
user_pref("accessibility.force_disabled", 1);
