# SteamDeck Auto TDP

**What is it?**

A service that allows the TDP to be set higher than 15w automatically while preserving functionality of the existing TDP control slider in the quick access menu **ON LCD DECKS**. I don't know if the OLED uses different files to control the TDP. You can try, but I don't know what will happen, and don’t recommend it.

**How does it work?**

The service is started automatically at boot and runs every few seconds to check the current maximum TDP setting. If it is 14w or lower, it does nothing. If it is 16w or higher, it does nothing. If it is exactly 15w, the service will run a script that will set the TDP to your desired maximum TDP setting. The idea being to still have a higher than stock TDP while being able to use the built in SteamOS TDP control slider. Just set the slider to 15w and it will be set to your desired higher-than-stock TDP automatically. 

*Note*: You must set the TDP higher than 15w in the deck bios for this to work. Otherwise, the bios will lock the TDP to 15w regardless of SteamOS settings.

**Why not just use PowerTools?**

The main reason I made this was that PowerTools, while an awesome plugin, has a deal-breaking bug for me. It limits the CPU clock speed to 3.5GHz max. This is no good for people like me who want to overclock the deck CPU. So the solution is to just not install PowerTools. However, that means no TDP control over 15w. Hence, this service. Basic, automatic TDP control while having a higher than stock CPU clock speed.

**Is there a better way?**

Definitely. This is just the quickest way I could think of.

**Installing**

To install this on your deck, choose your desired TDP folder (or make your own). I'm going to assume 20 so make sure to change your number if necessary.


Installing the files
```bash
sudo cp /path/to/ppt20W.service /etc/systemd/system/ppt20W.service
sudo cp /path/to/ppt20W.timer /etc/systemd/system/ppt20W.timer
sudo cp /path/to/ppt20w.sh /usr/bin
```
Make sure to take note of the lowercase w in the ppt20w.sh.

Make sure the script is executable
```bash
sudo chmod +x /usr/bin/ppt20w.sh
```

Enable and start the service
```bash
sudo systemctl daemon-reload
sudo systemctl enable ppt20W.timer
sudo systemctl enable ppt20W.service
```

Then run
```bash
sudo systemctl start ppt20W.timer
```
or reboot to start the service.

**FAQ**

Q: Will this work with my deck?

A: It works on my test suit of one LCD deck, so your milage may very. Tested SteamOS versions 3.5.7 through 3.5.17.

Q: Will this survive a major update?

A: Nope.

Q: Why would I use this over PowerTools?

A: No good reason if you’re not overclocking the CPU and trying to set a higher TDP at the same time. Maybe you don't like decky for some reason?

Q: I installed but the slider still says 15w

A: The script will set the TDP, but it wont change what the slider says. I don't know how to make it do that. You can check the current max TDP with
  ```bash
  cat /sys/class/hwmon/hwmon6/power1_cap
  ```
  and
  ```bash
  cat /sys/class/hwmon/hwmon6/power2_cap
  ```
  both should read your current max TDP in microwatts (six extra zeros).
