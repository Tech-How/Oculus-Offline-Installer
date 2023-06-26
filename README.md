# Oculus Offline Installer
An offline installer for the Oculus PC software.

## About
I created this project because I wanted a way to use my Oculus Quest completely disconnected from Facebook and their data-mining services. I kept my Oculus disconnected from the internet, and had their PC software blocked in my firewall. This worked great for my specific use case, which was primarily using SteamVR and other Open XR applications over a link cable. It then dawned on me that should I ever need to reinstall the PC software or my operating system, I would be out of luck since my workarounds could always be patched in the near future. I wanted everything to stay exactly how it was, frozen in time.

I originally came across a project by drosoCode, who wanted to achieve something similar. Updates to the PC software overtime had broken their work, so I decided to go on a hunt to develop one that worked with the latest PC software, and I came up with this. Whether you're like me and want to block Facebook, or just have a computer without internet access, this should have you covered. I would like to give a big thank you to drosoCode for the original project, which can be found [here](https://github.com/drosoCode/Offculus). As of now this project is archived and not receiving any more updates.

## How to Use
Accomplishing this task is not as easy as copying and pasting the Program Files directories. The official Oculus installer modifies various registry entries, installs system services and drivers, among other things. All of this needs to be replicated as closely as possible to the official installer in order to be a success.

For this, I created batch scripts. To get started, [download](https://github.com/Tech-How/Oculus-Offline-Installer/releases) the latest version of this project, and extract it to an empty, writable directory. If you plan to save your Oculus app for reinstallation in the future or use it on another computer, I recommend using an external storage device or backup service. To prepare this installer for the first time, you'll need to save your current Oculus software. You can do this by running the Backup script on a machine with Oculus already installed, and a headset configured.

After you've created a backup, you can install the PC software on any computer by running the Install script. During the installation process you'll be given the option to block communication with Facebook and Oculus. Use this mode if you only plan to use third-party Open XR applications like SteamVR, because the main Oculus library will not function. You can always block or unblock these connections later by running the respective scripts inside of the Network Backup folder.

## Other Notes
If you find any issues with this project, you can let me know by opening an issue report [here](https://github.com/Tech-How/Oculus-Offline-Installer/issues).
