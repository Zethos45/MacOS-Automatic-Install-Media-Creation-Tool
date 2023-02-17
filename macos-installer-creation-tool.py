import os

# Prompt for administrator privileges
#os.system("sudo -v")

# Define a dictionary with the names and paths of the macOS installers
installers = {
    "1": {"name": "Ventura",        "path": "/Applications/Install\ macOS\ Ventura.app/Contents/SharedSupport/InstallESD.dmg",       "size": 15},
    "2": {"name": "Monterey",       "path": "/Applications/Install\ macOS\ Monterey.app/Contents/SharedSupport/InstallESD.dmg",      "size": 15},
    "3": {"name": "Big Sur",        "path": "/Applications/Install\ macOS\ Big\ Sur.app/Contents/SharedSupport/InstallESD.dmg",      "size": 15},
    "4": {"name": "Catalina",       "path": "/Applications/Install\ macOS\ Catalina.app/Contents/SharedSupport/InstallESD.dmg",      "size": 1},
    "5": {"name": "Mojave",         "path": "/Applications/Install\ macOS\ Mojave.app/Contents/SharedSupport/InstallESD.dmg",        "size": 15},
    "6": {"name": "High Sierra",    "path": "/Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/InstallESD.dmg",  "size": 10},
    "7": {"name": "Sierra",         "path": "/Applications/Install\ macOS\ Sierra.app/Contents/SharedSupport/InstallESD.dmg",        "size": 8},
    "8": {"name": "El Capitan",     "path": "/Applications/Install\ OS\ X\ El\ Capitan.app/Contents/SharedSupport/InstallESD.dmg",   "size": 8}
}
print("Currently Supported MacOS Versions: " + installers["8"]["name"] + " - " + installers["1"]["name"])

## USB Drive Formatting & Detection Variables
## Find and store all external disks in variable/array 'extdisks'
#extdisks = {"os.system(diskutil list | grep external | awk '{ print $1}')"}
## Declare total number of external disks
#extnum = len(extdisks)

# Ask the user which macOS versions to include
print("Which macOS versions would you like to include on the USB drive?")
print("Enter the numbers separated by a space:")
for version in installers:
    print(version + ". " + installers[version]["name"])
versions = input().split()

## Declare the Minimum USB Size Required
usbsize = (0)
for version in versions:
    usbsize += (installers[version]["size"])
    
print(str(usbsize) + "GB")

input("Press Enter to continue...")

# Mount the installer images and create partitions and copy installers for each selected version
for version in versions:
    installer = installers[version]
    os.system("hdiutil attach " + installer["path"] + " -noverify -nobrowse -mountpoint /Volumes/install_app")

    partition_name = "Installer " + version + " - " + installer["name"]
    os.system("diskutil partitionDisk /dev/disk2 GPT JHFS+ '" + partition_name + "' 100% JHFS+ -format APFS -scheme GUIDPartitionScheme")
    os.system("sudo bless --folder /Volumes/" + partition_name.replace(" ", "\\ ") + "/System/Library/CoreServices --bootable --label '" + partition_name + "'")
    os.system("sudo " + installer["path"].replace(" ", "\\ ") + "/Contents/Resources/createinstallmedia --volume /Volumes/" + partition_name.replace(" ", "\\ ") + " --nointeraction")

    os.system("hdiutil detach /Volumes/install_app")

print("Done.")
