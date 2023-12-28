# Home assistant add-on: Minecraft Dedicated Server Java Edition
A quick way to run a Minecraft Dedicated Server Java Edition on Home Assistant.

## About

This addon uses the [itzg/docker-minecraft-server](https://github.com/itzg/docker-minecraft-server/) docker image.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add my Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install this add-on.
2. Change the API port if desired (defaults to standard minecraft port)
3. Click the `Save` button to store your configuration.
4. Make the directory /share/minecraft-server
5. Start the add-on.
6. Check the logs of the add-on to see if everything went well.
7. Edit any server/permissions/whitelist properties you want in /share/minecraft-server/ and restart addon . Note you cannot change the port in server.properties as it will get overridden for some reason. However, you can change the port in the addon configuration tab in homeassistant. I only expose the IP4 port.
8. If you want external access, be sure to forward your external port to your homeassistant IP.


[repository]: https://github.com/ruthem/HA-Addons