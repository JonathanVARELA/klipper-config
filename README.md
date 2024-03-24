# How to use
Add and run the following alias (change the path to the klipper-config folder if needed)

```bash
alias uklipper='cd ~/klipper-config && git checkout . && git pull && chmod +x update-config.sh && ./update-config.sh && cd ~'
```

Then run the alias `uklipper` to update the klipper configuration.