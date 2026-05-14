# HA-Addons

Custom Home Assistant add-ons by Ruthem.

## Add-ons

This repository contains the following add-ons:

### [OpenClaw Gateway](./openclaw-gateway)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

OpenClaw AI Gateway — verbinde deine KI mit Home Assistant.
Stellt eine WebSocket-Schnittstelle (Port 18789) bereit, über die OpenClaw mit HA kommunizieren kann.

- s6-overlay service management
- Alpine-based, lightweight
- Auto-generates auth token on first start
- Persistent workspace at `/config/openclaw`

### [Minecraft Server Java Edition](./minecraft-server)

![Supports amd64 Architecture][amd64-shield]

Minecraft Dedicated Server (Java Edition) v0.0.2.
Läuft auf Port 25565 (Standard). Maps auf `/addons` für persistenten Welten-Speicher.

### [Minecraft Server (Old)](./minecraft-server-old)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armv7 Architecture][armv7-shield]

Minecraft Dedicated Server (Java Edition) — Legacy-Version.
Nutzt Port 19132/udp. Maps auf `/share`.

---

## Installation

1. Gehe in Home Assistant zu **Einstellungen → Add-ons → Add-on-Store**
2. Klicke auf die drei Punkte (⋮) → **Repositories**
3. Füge folgende URL hinzu: `https://github.com/ruthem/HA-Addons`
4. Die Addons erscheinen im Store und können installiert werden

---

## About

Custom Home Assistant addons by Ruthem.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
