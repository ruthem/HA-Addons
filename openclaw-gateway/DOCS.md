# Home Assistant Add-on: OpenClaw Gateway

## About

Dieses Add-on startet den [OpenClaw Gateway](https://github.com/openclaw/openclaw) in Home Assistant.
OpenClaw ist ein KI-Assistent, der mit deinem Smart Home kommunizieren kann.

## Installation

1. Dieses Repository zum HA Add-on Store hinzufügen:
   - Settings → Add-ons → Add-on Store → ⋮ → Repositories
   - `https://github.com/ruthem/HA-Addons`
2. "OpenClaw Gateway" auswählen und installieren
3. Konfiguration anpassen (optional)
4. Starten

## Konfiguration

| Option | Beschreibung | Standard |
|--------|-------------|----------|
| `workspace_path` | Pfad für OpenClaw-Workspace (Config, Memory, etc.) | `/config/openclaw` |
| `verbose` | Ausführliche Log-Ausgabe | `false` |

## Ersteinrichtung

Nach dem Start erreichst du den Gateway unter `ws://<HA-IP>:18789`.

OpenClaw erstellt beim ersten Start automatisch:
- Die Konfigurationsdatei
- Den Workspace-Ordner
- Einen Gateway-Auth-Token (zu finden in den Logs)

## Wichtige Pfade

- **Konfiguration:** `/config/openclaw/.openclaw/openclaw.json`
- **Workspace:** `/config/openclaw/workspace/`