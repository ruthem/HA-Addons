# OpenClaw Gateway — Home Assistant Add-on Documentation

The **OpenClaw Gateway** add-on brings [OpenClaw](https://github.com/openclaw/openclaw) into your Home Assistant environment. It provides a self-contained, high-performance AI agent server with a built-in web terminal and gateway interface, optimized for Home Assistant OS (HAOS).

---

## Table of Contents
1. [Quick Start](#quick-start)
2. [Architecture & Storage](#architecture--storage)
3. [Providing Your Own Configuration](#providing-your-own-configuration-openclawjson)
4. [Accessing the Interface](#accessing-the-interface)
5. [Configuration Reference](#configuration-reference)
6. [Integrations](#integrations)
   - [Home Assistant Assist](#home-assistant-assist)
   - [MCP (Smart Home Control)](#mcp-smart-home-control)
   - [Browser Automation](#browser-automation)
7. [Maintenance & Persistence](#maintenance--persistence)
8. [Troubleshooting](#troubleshooting)
9. [Local Development & Testing](#local-development--testing)

---

## Quick Start

### 1. Installation
*   Go to **Settings → Add-ons → Add-on store**.
*   Click the three dots (top-right) → **Repositories**.
*   Add: `https://github.com/ruthem/HA-Addons`.
*   Find **OpenClaw Gateway** and click **Install**.

### 2. First Run
*   Click **Start**.
*   Open the **Web UI**. You'll see a landing page with a terminal.
*   In the terminal, run the setup wizard:
    ```bash
    openclaw onboard
    ```
*   Follow the prompts to set up your AI providers (e.g., OpenAI, Anthropic, Gemini).

### 3. Retrieve Your Token
The gateway uses a token for security. To get it, run:
```bash
jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json
```
Save this token; you will need it to login to the Gateway Control UI.

---

## Architecture & Storage

The add-on runs three primary services:
*   **OpenClaw Gateway**: The core AI server (default port `18789`).
*   **ttyd**: A web terminal for command-line management (default port `7681`).
*   **nginx**: An internal proxy that serves the add-on's landing page.

### Important Directories
Data stored in `/config` (mapped to `/addon_configs/openclaw-gateway` on your host) survives updates and backups:

| Path | Purpose |
| :--- | :--- |
| `/config/.openclaw/` | Configuration (`openclaw.json`), identity, and internal state. |
| `/config/openclaw/` | Workspace for skills, agent data, and ClawHub files. |
| `/config/.node_global/` | Persisted NPM packages (skills installed via dashboard). |
| `/config/.linuxbrew/` | Homebrew installation and custom CLI tools. |
| `/config/secrets/` | Secure tokens (e.g., Home Assistant access tokens). |

---

## Providing Your Own Configuration (openclaw.json)

While the add-on can generate a configuration for you via the `openclaw onboard` command, you may want to provide your own pre-configured `openclaw.json` file.

### Where to place the file
You can provide the file by placing it in any of the directories mapped to the add-on:
*   **/config/**: This corresponds to `/addon_configs/openclaw-gateway` on your Home Assistant host.
*   **/share/**: Use this if you want to manage the file via the Samba/Windows Networking add-on (recommended for easy manual edits).

Example: Place your file at `/share/openclaw.json`.

### How to configure the path
1. Open the **OpenClaw Gateway** add-on in Home Assistant.
2. Go to the **Configuration** tab.
3. In the `config_path` field, enter the full path to your file (e.g., `/share/openclaw.json`).
4. Click **Save** and **Restart** the add-on.

The add-on will now use your provided file instead of the default one in `/config/.openclaw/openclaw.json`.

---

## Accessing the Interface

Modern browsers require a **Secure Context** (HTTPS or localhost) to access the OpenClaw Control UI.

### Option 1: Built-in HTTPS (`lan_https`) - *Recommended*
This is the easiest way to get secure access on your local network.
1. In the add-on **Configuration**, set `access_mode` to `lan_https`.
2. Restart the add-on.
3. On the landing page, click **Download CA Certificate**.
4. Install this certificate on your device (Phone or PC) to trust the connection.
5. Click **Open Gateway Web UI** to access via HTTPS.

### Option 2: External Reverse Proxy (`lan_reverse_proxy`)
If you use Nginx Proxy Manager or Caddy:
1. Set `access_mode` to `lan_reverse_proxy`.
2. Set `gateway_trusted_proxies` to your proxy's IP address.
3. Configure your proxy to point to your HA IP on port `18789`.

### Option 3: SSH Tunneling
For desktop users, you can forward the port via SSH:
```bash
ssh -L 18789:127.0.0.1:18789 your-ha-user@your-ha-ip
```
Then visit `http://localhost:18789`.

---

## Configuration Reference

| Option | Default | Description |
| :--- | :--- | :--- |
| `workspace_path` | `/config/openclaw` | Path for skills and agent workspace. |
| `config_path` | | Optional custom path for `openclaw.json`. |
| `access_mode` | `custom` | Preset for network security (`lan_https`, `lan_reverse_proxy`, etc.). |
| `gateway_port` | `18789` | The port for the Gateway UI. |
| `enable_openai_api` | `false` | Enables OpenAI-compatible API for HA Assist. |
| `auto_configure_mcp` | `false` | Automatically registers Home Assistant as an MCP server. |
| `homeassistant_token` | | Long-lived access token for HA control. |
| `force_ipv4_dns` | `true` | Fixes network timeouts in IPv4-only environments. |
| `timezone` | `UTC` | Local timezone for logs and scheduled tasks. |

---

## Integrations

### Home Assistant Assist
Use OpenClaw as your primary conversation agent in Home Assistant:
1. Enable `enable_openai_api` in the add-on settings.
2. Install the **OpenClaw Integration** (via HACS).
3. In Home Assistant, go to **Settings → Voice Assistants** and select OpenClaw.

### Smart Home Control (MCP)
Give OpenClaw the ability to control your devices using the Model Context Protocol:
1. Create a **Long-Lived Access Token** in your HA profile.
2. Paste it into the `homeassistant_token` field in the add-on configuration.
3. Enable `auto_configure_mcp`.
4. OpenClaw can now turn on lights, read sensor data, and execute scripts.

### Browser Automation
OpenClaw includes a headless **Chromium** browser. To enable it for web-based skills, add this to your `openclaw.json`:
```json
"browser": {
  "enabled": true,
  "headless": true,
  "noSandbox": true
}
```

---

## Bundled Tools & CLI

The add-on environment comes pre-loaded with several tools for advanced users:
*   **Version Control**: `git`, `gh` (GitHub CLI)
*   **Editors**: `vim`, `nano`
*   **Processing**: `jq`, `python3`, `node` (v22), `npm`, `pnpm`
*   **Networking**: `curl`, `ssh`, `rsync`
*   **Package Management**: `brew` (Homebrew) is available for installing additional CLI tools.

### Google APIs (gog)
If you use skills that require Google OAuth (like Sheets or Gmail), use the `--manual` flag during authentication to handle the redirect correctly within the container:
```bash
gog auth add your-email@gmail.com --services sheets --manual
```

---

## Maintenance & Persistence

### Updates
When you update the add-on, the core software is replaced, but your configuration, workspace, and installed skills (via NPM or Homebrew) are automatically preserved because they are stored in the `/config` directory.

### Cleaning Up
If you run low on disk space, use the built-in utility in the terminal:
```bash
oc-cleanup
```
This tool helps you clear NPM/PNPM caches and temporary files.

### Backups
Add-on data is automatically included in standard Home Assistant backups.

---

## Troubleshooting

### "Unauthorized" error in Web UI
Ensure you are using the correct token. You can check it in the terminal:
`jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json`

### Control UI "Requires HTTPS"
OpenClaw v2026.2.21+ mandates a secure context. Use `lan_https` mode or an external reverse proxy as described in the [Accessing the Interface](#accessing-the-interface) section.

### Network Timeouts / Skills Failing
If skills like `web_search` fail, ensure `force_ipv4_dns` is set to `true`. Many Home Assistant environments have issues with IPv6 DNS resolution.

### Resetting to Factory Defaults
To start over completely, stop the add-on and run:
`rm -rf /config/.openclaw /config/openclaw /config/.node_global`
Then restart. **Warning: This deletes all configuration and skills.**

---

For further help, visit the [OpenClaw GitHub repository](https://github.com/openclaw/openclaw).


---

## Local Development & Testing

If you want to test the add-on or develop new skills without deploying it to a Home Assistant instance, you can run it locally using Docker Compose.

### Prerequisites
- Docker and Docker Compose installed on your machine.
- Git (to clone the repository).

### Steps
1. Navigate to the `openclaw-gateway` directory:
   ```bash
   cd openclaw-gateway
   ```
2. Build and start the container:
   ```bash
   docker-compose up --build
   ```
3. Access the interfaces:
   - **Gateway UI**: `http://localhost:18789`
   - **Web Terminal**: `http://localhost:7681` (or via the landing page at `http://localhost:48099`)

### Configuration
The local environment uses a multi-arch base image (`debian:bookworm-slim`) by default, making it compatible with both Intel/AMD and Apple Silicon (ARM) machines.

It also uses the `test-data` folder to simulate the Home Assistant `/data` partition. You can modify `test-data/options.json` to change add-on settings for your local run.
