# OpenClaw Gateway Add-on

Home Assistant Add-on für [OpenClaw](https://github.com/openclaw/openclaw) — deinen KI-Assistenten.

## Key Features
- **AI Gateway** — OpenClaw server with chat, skills, and automation capabilities.
- **Web Terminal** — browser-based terminal embedded in Home Assistant (Ingress).
- **Assist Pipeline** — use OpenClaw as a conversation agent via the OpenAI-compatible API.
- **Browser Automation** — Chromium included for web scraping and automation skills.
- **Proxy Support** — optional outbound `http_proxy` setting.
- **Homebrew** — supports OpenClaw skills that require external CLI tools.
- **Custom Config** — supports providing a custom `openclaw.json` path via UI.

## Local Testing
You can try this add-on locally (outside of Home Assistant) using Docker Compose. The environment is multi-arch (Intel/AMD/ARM) and uses `debian:bookworm-slim` as a base.

1. Navigate to the `openclaw-gateway` folder.
2. Run `docker compose up --build`.
3. Open `http://localhost:18789` in your browser.
