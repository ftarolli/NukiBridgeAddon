# NukiBridgeAddon
The add-on version of the simple [Nuki Bridge](https://nuki.io/en/bridge/) implementation using asyncio developed by [Dauden1184](https://github.com/dauden1184/RaspiNukiBridge).

Minimal implementation of the Nuki Bridge protocols in python (both HTTP and BLE).  
Right now **pairing**, **lock**, **unlock**, **unlatch** and HTTP callbacks are implemented, it works fine with the [Homeassistant Nuki integration](https://www.home-assistant.io/integrations/nuki/) and the [hass_nuki_ng integration](https://github.com/kvj/hass_nuki_ng).

Refer to [Dauden1184](https://github.com/dauden1184/RaspiNukiBridge) for further code information.

# Home Assistant add-on installation

1. Copy the repository files into local ADDON folder.
2. Open the Home Assistant frontend and go to "Configuration"
3. Click on "Add-ons, backups & Supervisor"
4. Click "add-on store" in the bottom right corner.
5. Open your Home Assistant instance and show the Supervisor add-on store.
6. On the top right overflow menu, click the "Check for updates" button. You should now see a new section at the top of the store called "Local add-ons" that lists this add-on!
7. Click on NukiBridgeAddon to go to the details page and install the add-on.
8. Go to the add-on configuration and add your lock MAC address. You can find it using a BLE app on your smartphone or through your PI directly (by ssh)
```
sudo bluetoothctl
agent on
default-agent
scan on
```
9. Now put your lock into discovery mode (hold the central button for 6sec until it lights up)
10. Start the addon
11. Click on the "Logs" tab, and refresh the logs of your add-on. Your should see what's going on.


Install either:
1. [hass_nuki_ng integration](https://github.com/kvj/hass_nuki_ng)
2. [Homeassistant Nuki integration](https://www.home-assistant.io/integrations/nuki/)

Use *localhost as host and about the token have a look inside the log once the add-on is started.
```
BRIDGE DATA:
app_id: 0000000000
token: 0000000000000000000000000000000000000000000000000000000
```

# Advanced
## Verbose

In case of issues you can change the level of verbose modifing the value inside "Configuration".

0 = only info [default]
1 = ERROR
2 = DEBUG
