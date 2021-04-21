#!/bin/bash

# Filename = upload.sh
# Author = Dave Van Dorsten
# Created = March 22 2021
# Modified = March April 01 2021

## Colour Codes
nocol="\033[39m"
black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
lightgray="\033[37m"
darkgray="\033[90m"
lightred="\033[91m"
lightgreen="\033[92m"
lightyellow="\033[93m"
lightblue="\033[94m"
lightmagenta="\033[95m"
lightcyan="\033[96m"
white="\033[97m"

SHARE_FILE () {
read -r -d '' UPLOAD_BANNER << EOM
██╗   ██╗██████╗ ██╗      ██████╗  █████╗ ██████╗     ███████╗██╗██╗     ███████╗
██║   ██║██╔══██╗██║     ██╔═══██╗██╔══██╗██╔══██╗    ██╔════╝██║██║     ██╔════╝
██║   ██║██████╔╝██║     ██║   ██║███████║██║  ██║    █████╗  ██║██║     █████╗  
██║   ██║██╔═══╝ ██║     ██║   ██║██╔══██║██║  ██║    ██╔══╝  ██║██║     ██╔══╝  
╚██████╔╝██║     ███████╗╚██████╔╝██║  ██║██████╔╝    ██║     ██║███████╗███████╗
 ╚═════╝ ╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝     ╚═╝     ╚═╝╚══════╝╚══════╝
                                                                                 
EOM
while true; do
	clear
	echo "$UPLOAD_BANNER"
	# UPLOAD variable holds the url of the last url used. Here it is checking if it holds a string
	if [[ -z "$upload" ]]; then
		echo -e "${lightcyan}https://transfer.sh${nocol}"
	else
		echo -e "Last upload URL: ${green}$upload${nocol}"
	fi
	echo -e "${yellow}\nFiles found in directory: $PWD${nocol}"
	# List command '-p' indicator style equals slash, using grep '-v' to reverse match to show only files and no directories
	ls -p | grep -v / 2>/dev/null
	echo ""
	read -p "Enter Filename: " fname
	if [[ -z "$fname" ]] ||[[ ! -f "$fname" ]]; then
		read -p "Invalid Filename, press ANY key to CONTINUE and REFRESH directory: "
		clear
		SHARE_FILE
	fi
	read -p "Randomize File Name? (y/N): "
		if [[ "$REPLY" == "y" ]]; then
			# RANDOMFILENAME
			rfname=$(</dev/urandom tr -dc '1-9A-Za-z' | head -c10)
			# UPLOAD file using variable for file name, using formatting .${variable: -3} to select the last three characters to preserve extention 
			upload=$(curl --upload-file ./$fname https://transfer.sh/$rfname".${fname: -3}")
			if [[ $? -eq 0 ]]; then
				echo -e "${green}$upload${nocol}\n"
				read -p "Upload Complete..."
				SHARE_FILE
		else
			read -p "Error"
			SHARE_FILE
			fi
		fi
	upload=$(curl --upload-file ./$fname https://transfer.sh/$fname)
	if [[ $? -eq 0 ]]; then
		echo -e "${green}$upload${nocol}\n"
		read -p "Upload Complete..."
		SHARE_FILE
		break
	else
		read -p "Error with Upload..."
		SHARE_FILE
		break
	fi
done

}
SHARE_FILE
