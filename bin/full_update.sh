#!/bin/bash
# Full apt package update script

sudo apt update
echo -e "\n\tUPDATE DONE\n"

sudo apt upgrade -y
echo -e "\n\tUPGRADE DONE\n"

sudo apt autoremove -y
echo -e "\n\tAUTO-REMOVE DONE\n"
