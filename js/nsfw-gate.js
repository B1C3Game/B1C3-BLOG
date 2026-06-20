(function () {
  "use strict";

  var STORAGE_KEY = "b1c3_nsfw_consent_v1";
  var content = document.getElementById("nsfw-content");
  var popup = document.getElementById("nsfw-consent");
  var ageCheck = document.getElementById("nsfw-age-check");
  var lolCheck = document.getElementById("nsfw-lol-check");
  var minimalButton = document.getElementById("nsfw-minimal");
  var acceptAllButton = document.getElementById("nsfw-accept-all");
  var resetButton = document.getElementById("nsfw-reset-consent");

  function parseConsent() {
    try {
      var raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) {
        return null;
      }
      return JSON.parse(raw);
    } catch (error) {
      return null;
    }
  }

  function writeConsent(analyticsEnabled) {
    var payload = {
      version: 1,
      entered: true,
      ageConfirmed: true,
      lolAccepted: true,
      analyticsEnabled: !!analyticsEnabled,
      timestamp: new Date().toISOString()
    };

    localStorage.setItem(STORAGE_KEY, JSON.stringify(payload));
    return payload;
  }

  function showContent() {
    if (content) {
      content.hidden = false;
    }
    if (popup) {
      popup.hidden = true;
    }
    document.body.classList.add("nsfw-open");
  }

  function showGate() {
    if (content) {
      content.hidden = true;
    }
    if (popup) {
      popup.hidden = false;
    }
    document.body.classList.remove("nsfw-open");
  }

  function loadAnalyticsIfAllowed(consent) {
    if (!consent || !consent.analyticsEnabled) {
      return;
    }

    if (window.__b1c3AnalyticsLoaded) {
      return;
    }

    function loadScript(src, onLoad, defer) {
      var script = document.createElement("script");
      script.src = src;
      if (defer) {
        script.defer = true;
      }
      if (typeof onLoad === "function") {
        script.onload = onLoad;
      }
      document.head.appendChild(script);
    }

    loadScript("../js/analytics-config.js", function () {
      loadScript("../js/analytics.js", null, true);
    });

    window.__b1c3AnalyticsLoaded = true;
  }

  function canEnter() {
    return !!(ageCheck && ageCheck.checked && lolCheck && lolCheck.checked);
  }

  function enter(analyticsEnabled) {
    if (!canEnter()) {
      alert("Confirm age and LOL warning before entering.");
      return;
    }

    var consent = writeConsent(analyticsEnabled);
    showContent();
    loadAnalyticsIfAllowed(consent);
  }

  function initializeFromStoredConsent() {
    var consent = parseConsent();
    if (consent && consent.entered && consent.ageConfirmed && consent.lolAccepted) {
      showContent();
      loadAnalyticsIfAllowed(consent);
      return;
    }

    showGate();
  }

  if (minimalButton) {
    minimalButton.addEventListener("click", function () {
      enter(false);
    });
  }

  if (acceptAllButton) {
    acceptAllButton.addEventListener("click", function () {
      enter(true);
    });
  }

  if (resetButton) {
    resetButton.addEventListener("click", function () {
      localStorage.removeItem(STORAGE_KEY);
      showGate();
    });
  }

  initializeFromStoredConsent();
})();
