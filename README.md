# NukiBridgeAddon
The addon version of the simple [Nuki Bridge](https://nuki.io/en/bridge/) implementation using asyncio developed by [Dauden1184](https://github.com/dauden1184/RaspiNukiBridge).

Minimal implementation of the Nuki Bridge protocols in python (both HTTP and BLE).  
Right now **pairing**, **lock**, **unlock**, **unlatch** and HTTP callbacks are implemented, it works fine with the [Homeassistant Nuki integration](https://www.home-assistant.io/integrations/nuki/) and the [hass_nuki_ng integration](https://github.com/kvj/hass_nuki_ng).

Refer to [Dauden1184](https://github.com/dauden1184/RaspiNukiBridge) for further code information.

# Home Assistant addon installation

1. Copy the repository files into local ADDON folder.
2. Open the Home Assistant frontend and go to "Configuration"
3. Click on "Add-ons, backups & Supervisor"
4. Click "add-on store" in the bottom right corner.
5. Open your Home Assistant instance and show the Supervisor add-on store.
6. On the top right overflow menu, click the "Check for updates" button. You should now see a new section at the top of the store called "Local add-ons" that lists this add-on!
7. Click on NukiBridgeAddon to go to the details page and install the add-on.
8. Go to the addon configuration and add your lock MAC address. You can find it using a BLE app on your smartphone or through your PI directly (by ssh)
> sudo bluetoothctl
> agent on
> default-agent
> scan on
9. Now put your lock into discovery mode (hold the central button for 6sec until it lights up)
10. Start the addon
11. Click on the "Logs" tab, and refresh the logs of your add-on. Your should see what's going on.


Install either:
1. [hass_nuki_ng integration](https://github.com/kvj/hass_nuki_ng)
2. [Homeassistant Nuki integration](https://www.home-assistant.io/integrations/nuki/)
# Advanced
## Connection timeout and retries

In case of issues during the bluetooth connection to the nuki device, it is possible to set a higher connection timeout and the number of retries with the fields `connection_timeout` (default is 10 seconds) and `retry` (default is 3) like this:

```
smartlock:
  - address: XX:XX:XX:XX:XX:XX
    bridge_public_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    bridge_private_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    nuki_public_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    auth_id: xxxxxxxx
    connection_timeout: 30
    retry: 5
```
