#!/usr/bin/env bash
# Youtube-Dl command
RED='\033[0;31m'
GRN='\033[0;32m'
BLU='\033[0;34m'
MAG='\033[0;35m'
CYAN="\033[0;36m"
NC='\033[0m'
echo ""35
echo ""
echo -e "Video Downloader using ${RED}youtube-dl:${NC}"
echo ""
echo ""
PS3='Please enter your choice: '
options=("Install Youtube-Dl" "Download Youtube Playlists" "Manual" "FAQ" "Supported Platforms" "Source Code" "Help" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Install Youtube-Dl")
			echo ""
			echo -e "${CYAN}You Chose Install Youtube-Dl${NC}"
			echo ""
			PS3='Please choose the methods: '
			options=("HomeBrew" "MacPorts" "cURL" "PyPI" "Wget")
			select opt in "${options[@]}"
			do
				case $opt in
					"HomeBrew")
					brew install youtube-dl
					;;
					"MacPorts")
					if [[ "$OSTYPE" == "darwin"* ]]; then
						sudo port install youtube-dl
					else echo -e "${RED}MacPorts is for MacOS (OS X) only${NC}"
					fi
					;;
					"cURL")
					sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
					sudo chmod a+rx /usr/local/bin/youtube-dl
					;;
					"PyPI")
					sudo -H pip install --upgrade youtube-dl
					;;
					"Wget")
					sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
					sudo chmod a+rx /usr/local/bin/youtube-dl
					;;
					*) echo "invalid option $REPLY"
				esac
			done
			if [ $? != 0 ]
			then
				echo -e "See the FAQ here: ${CYAN}https://github.com/ytdl-org/youtube-dl#faq${NC}"
			fi
			;;
		"Download Youtube Playlists")
			echo ""
			echo -e "${GRN}You Chose To Download Youtube Playlists${NC}"
			echo ""
			read -e -p "Please Enter Where You Want To Store the File: " FILEPATH
			echo ""
			read -e -p "Please Enter The Playlists URL: " URL
			youtube-dl -o "${FILEPATH}/%(uploader)s/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" ${URL}
			if [ $? != 0 ]
			then
				echo -e "See the FAQ here: ${CYAN}https://github.com/ytdl-org/youtube-dl#faq${NC}"
			fi
			;;
		"Manual")
			echo ""
			echo -e "${GRN}You Chose To Enter The Command Manually${NC}"
			echo ""
			read -e -p "Please Enter Your Options: " OPTS
			echo ""
			read -e -p "Please  The (Playlists) URL: (Skip if you don't want to download anything)" URL
			youtube-dl "${OPTS}" ${URL}
			if [ $? != 0 ]
			then
				echo -e "See here to fix some issue: ${CYAN}https://github.com/ytdl-org/youtube-dl#faq${NC}"
			fi
		;;
		"Help")
		youtube-dl --help
			;;
		"FAQ")
		if [[ "$OSTYPE" == "darwin"* ]]; then
			open https://github.com/ytdl-org/youtube-dl#faq
		elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
			xdg-open https://github.com/ytdl-org/youtube-dl#faq
		elif [[ "$OSTYPE" == "win32" ]]; then
			start https://github.com/ytdl-org/youtube-dl#faq
		fi
		;;
		"Supported Platforms")
		if [[ "$OSTYPE" == "darwin"* ]]; then
			open https://ytdl-org.github.io/youtube-dl/supportedsites.html
		elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
			xdg-open https://ytdl-org.github.io/youtube-dl/supportedsites.html
		elif [[ "$OSTYPE" == "win32" ]]; then
			start https://ytdl-org.github.io/youtube-dl/supportedsites.html
		fi
		;;
		"Source Code")
		if [[ "$OSTYPE" == "darwin"* ]]; then
			open https://github.com/ytdl-org/youtube-dl
		elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
			xdg-open https://github.com/ytdl-org/youtube-dl
		elif [[ "$OSTYPE" == "win32" ]]; then
			start https://github.com/ytdl-org/youtube-dl
		fi
		;;
		"Config")
		read -e -p "Please Enter Where You Want To Store the File: " OPTIONS
		if [[ "$OSTYPE" == "darwin"* ]]; then
			echo "$OPTIONS" > ~/.config/youtube-dl/config.conf
		elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
			echo "$OPTIONS" > ~/.config/youtube-dl/config.conf
		elif [[ "$OSTYPE" == "win32" ]]; then
			echo "$OPTIONS" > ~/youtube-dl.conf
		fi
		;;
		"Quit")
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done
