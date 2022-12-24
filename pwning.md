# How can you pwn?

1. Gaster on CMD 
2. Gaster on MSYS2 MINGW64

# 1st way

Step 1: Connect ur iPhone on DFU mode.

Step 2: Open Zadig

Step 3: Replace libusbK drivers to your iPhone

Step 4: Open CMD and cd into /path/to/gaster

Step 5: Move gaster file to command prompt and add '' pwn '' to command

Step 6: If its not worked on first time, then replace libusbK drivers again in Zadig

Step 7: If gaster says '' Now you can boot untrusted images '' you are good

Step 8: Open Zadig again and replace WinUSB drivers to your iPhone

Step 9: Open usb folder and right click AppleUsb.inf and click install

# 2st way 

Step 1: Install vim , git , mingw-w64-x86_64-toolchain , mingw-w64-x86_64-gcc , mingw-w64-libusb , mingw-w64-libusbmuxd in MSYS2 MINGW64 Shell
Step 2: Clone gaster with: git clone https://github.com/joshuah345/gaster
Step 3: cd gaster
Step 4: Run '' make CC=gcc libusb ''
Step 5: Run ./gaster pwn
Step 6: Open Zadig
Step 7: Replace libusbK drivers to your iPhone
Step 8: If its not worked on first time, then replace libusbK drivers again in Zadig
Step 9: If gaster says '' Now you can boot untrusted images '' you are good
Step 10: Open Zadig again and replace WinUSB drivers to your iPhone
Step 11: Open usb folder and right click AppleUsb.inf and click install
