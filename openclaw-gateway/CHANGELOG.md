<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

## 0.2.1

- Feat: Added GitHub CLI (`gh`) to the container

## 0.2.0

- Feat: Comprehensive feature set (Debian-based, ttyd, Chromium, Homebrew, etc.)
- Feat: Support for custom `openclaw.json` path via UI
- Build: Switch to Debian Bookworm base image for better compatibility

## 0.1.1

- Fix: s6 Service-Skripte (run/finish) jetzt ausführbar

## 0.1.0

- Initial release
- OpenClaw Gateway als Home Assistant Add-on
- Persistenter Workspace in `/config/openclaw`
- Konfigurierbarer WebSocket-Port (18789)
