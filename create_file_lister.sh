#!/usr/bin/env bash
if [[ "$#" -eq 0 ]]; then
	printf "Missing mandatory parameter: DEVELOPER_NAME.\n";
	printf "Usage: $0 DEVELOPER_NAME\n";
	printf "Example: $0 \"Native Instruments\"\n";
	exit 1;
fi

DEVELOPER_NAME=$1;
DEVELOPER_NAME_IN_LOWER_SNAKE_CASE=$(echo $DEVELOPER_NAME | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g');

FILE_LISTER_SCRIPT_FILE_NAME="list_files_for_${DEVELOPER_NAME_IN_LOWER_SNAKE_CASE}_plugins.sh";
PLUGINS_LIST_FILE_NAME="${DEVELOPER_NAME_IN_LOWER_SNAKE_CASE}_plugins.txt";

if [[ ! -f "file_lister_template.sh" ]]; then
	printf "\e[91mFile \e[32;1mfile_lister_template.sh \e[91;21m is not found in this directory. It is required for this script to work.\e[0m\n";
	exit 66;
fi

cat file_lister_template.sh | sed "s/__DEVELOPER__/$1/" > ${FILE_LISTER_SCRIPT_FILE_NAME};
chmod 755 ${FILE_LISTER_SCRIPT_FILE_NAME};
touch ${PLUGINS_LIST_FILE_NAME};
chmod 644 ${PLUGINS_LIST_FILE_NAME};

printf "File lister script \e[92m${FILE_LISTER_SCRIPT_FILE_NAME}\e[0m created.\n";
printf "Now you must create a file listing the plugins from \e[94m${DEVELOPER_NAME}\e[0m which you want to list the files for.\n";
printf "The name of the plugin list file must be \e[32;1m${PLUGINS_LIST_FILE_NAME}\e[0m, and it must contain one plugin name per line.\n";
printf "An empty file for the plugin list (\e[32;1m${PLUGINS_LIST_FILE_NAME}\e[0m) is already created for you, you just have to fill it up.\n";
printf "See the files in directory \e[32;1mexamples\e[0m for an example.\n";
printf "After you have created the plugin list file (\e[32;1m${PLUGINS_LIST_FILE_NAME}\e[0m), you can run the uninstaller script file (\e[92m${UNINSTALLER_SCRIPT_FILE_NAME}\e[0m).\n"
printf "It must be run as root, so use sudo. For example: \e[93;1msudo ./${FILE_LISTER_SCRIPT_FILE_NAME}\e[0m\n";
printf "It will only work correctly if you have installed the plugins in their default directories.\n";
printf "If you have installed them somewhere else, the file lister script will not find everything.\n";

