# MacOS plugin uninstaller

Uninstalls all VST/AU/AAX plugins listed in a text file.

## How to use it for uninstalling plugins

Run *./create_uninstaller.sh <DEVELOPER_NAME>*, for example *./create_uninstaller.sh "Native Instruments"*.

The script creates an uninstaller script for you and gives you further instructions on how to proceed. Basically, you must make a file listing the plugins to be uninstalled, and then run the created uninstaller script with sudo.

Sometimes there will be some manual work still left afterwards, especially if you have installed the plugins in non-default locations. Still, the uninstaller script created by this tool does a lot of work, so you will have less things to do manually afterwards compared to the situation where you would do the uninstall completely manually. Uninstalling plugins is quite complex (they write files in so many places in your file system) and plugin vendors don't usually provide you with any kind of uninstaller (some do, but most don't).

## Making the plugin list file

Sometimes "one plugin" actually contains several plugins (versions with a different number of channels, separate content libraries etc.)

You have to mention these all in the plugin list file.

See *examples/native_instruments_plugins.txt* for a good example of plugins where the 3 "main" plugins actually contain 11 plugins which have to be removed.

## How to use it for listing plugin files

Sometimes you don't want to necessarily remove a plugin, but only see a list of all the files that the plugin has created in your filesystem - to check (and possibly fix) the contents of some metadata file, for example. In that case you do everything else exactly the same way as when uninstalling plugins, but you just run script *./create_file_lister.sh <DEVELOPER_NAME>* instead of *./create_uninstaller.sh <DEVELOPER_NAME>* in the beginning. This creates a file lister script, and by running it you see all the files which belong to the plugin(s) (and also all the places where there _might_ be files, but are not, so you see if there are some important files missing).

### This script is only intended for MacOS. It does not work on Windows on Linux.

