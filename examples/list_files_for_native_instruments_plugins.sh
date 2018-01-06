#!/usr/bin/env bash
DEVELOPER="Native Instruments";
PLUGINS_LIST_FILE_NAME=$(echo "$DEVELOPER" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g' | sed 's/$/_plugins.txt/g');
PLIST_PREFIX=$(echo "$DEVELOPER" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/^/com./g');
printf "\e[91mThis script is going to remove all your plugins from \e[96m${DEVELOPER} \e[95m(${PLIST_PREFIX}.*).\e[0m\n";

if [[ ! -f ${PLUGINS_LIST_FILE_NAME} ]]; then
	printf "\e[91mFile \e[32;1m${PLUGINS_LIST_FILE_NAME}\e[91;21m is not found in this directory. It is required for listing the plugins to list files for.\e[0m\n";
	exit 66;
fi

printf "\e[91mThis means the following plugins (read from file \e[32m${PLUGINS_LIST_FILE_NAME}):\e[0m\n";
printf "\e[34;4m%s\e[0m\n" "$(cat ${PLUGINS_LIST_FILE_NAME} | awk 'NF {print $0}' | cat -b)";

if [[ "$EUID" -ne "0" ]]; then
	printf "\e[91mThis script can only be run as root. Please run with sudo:\e[39;1m sudo ./$(basename $0)\n";
	exit 77;
fi

IFS=$'\n';
for PLUGIN in $(awk 'NF {print $0}' ${PLUGINS_LIST_FILE_NAME}); do
	printf "\e[95m--- ${PLUGIN} ---\e[0m\n";
	set -x;
	ls "/Applications/${DEVELOPER}/${PLUGIN}";
	ls "/Library/Audio/Plug-Ins/VST/${PLUGIN}.vst";
	ls "/Library/Audio/Plug-Ins/Components/${PLUGIN}.component";
	ls "/Library/Application Support/Avid/Audio/Plug-Ins/${PLUGIN}.aaxplugin";
	ls "${HOME}/Documents/${DEVELOPER}/${PLUGIN}";
	ls "${HOME}/Library/Preferences/${PLIST_PREFIX}.${PLUGIN}.plist";
	ls "/Library/Application Support/${DEVELOPER}/${PLUGIN}";
	# NKS Settings: These are always under "Native Instruments" and "com.native-instruments", regardless of the developer.
	ls "/Library/Application Support/Native Instruments/Service Center/${PLUGIN}.xml";
	ls "/Library/Preferences/com.native-instruments.${PLUGIN}.plist";
	{ set +x; } 2>/dev/null;
done;

