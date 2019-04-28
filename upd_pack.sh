#!/bin/bash
echo ==========
echo Check root
echo ==========
if [[ $UID == 0 ]]; then
	echo "Please run this script WITHOUT sudo:"
	echo "$0 $*"
	exit 1
fi

echo ===========
echo pacman -Syu
echo ===========
sudo pacman -Syu

echo ============
echo List Orphans
echo ============
orphans=$(sudo pacman -Qdt)

if [ -z "$orphans" ]
then
	echo No oprhans
else
	echo ==============
	echo Remove Orphans
	echo ==============
	sudo pacman -Rsn $(sudo pacman -Qdtq)
fi	

echo ====================
read -e -p "Update AUR Packages? " -i "Y" REPLY
echo ====================
if [[ $REPLY =~ ^[Yy]$ ]]
then
	#sudo echo "SUDO HACK"
	user=$(whoami)
	echo "Change user to '\$(whoami)'"
	yay -Syua
fi
