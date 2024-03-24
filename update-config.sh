#!/bin/bash
git pull

# this script is located at the root of the project
# do not use zenity, use native bash dialog boxes
# each folder at the root of the project represent a config file for a given printer (ex: a10m, ender3, etc...)
# first of all, open a dialog box to select the printer config file to update
# then, check if the folder with the same name exists in the home directory ex: ~/a10m
# if it doesn't exist, create it
# then, check if the file printer.cfg exists in the folder ~/
# if it doesn't exist, copy it from the project folder to the home folder
# then, check if the folder config exists in the folder ~/a10m
# if it doesn't exist, create it
# then, clear the contents of the folder ~/a10m/config
# copy the contents of the project config folder to the newly created config folder ex: cp -r a10m/config/* ~/a10m/config/
# finally, send a message to the user that the update is complete
# Code :

# Select a printer config file
printer_cfg=$(dialog --stdout --title "Select a printer config file" --fselect /home/pi/ 14 48)
# Check if the folder with the same name exists in the home directory
printer_folder=$(basename $printer_cfg)
if [ ! -d ~/printer_folder ]; then
    mkdir ~/printer_folder
fi
# Check if the file printer.cfg exists in the folder ~/
if [ ! -f ~/printer.cfg ]; then
    cp $printer_folder/printer.cfg ~/printer.cfg
fi
# Check if the folder config exists in the folder ~/{printer_folder}
if [ ! -d ~/printer_folder/config ]; then
    mkdir ~/printer_folder/config
fi
# Clear the contents of the folder ~/{printer_folder}/config
rm -rf ~/printer_folder/config/*
# Copy the contents of the project config folder to the newly created config folder
cp -r $printer_folder/config/* ~/printer_folder/config/
# Send a message to the user that the update is complete
dialog --title "Update Complete" --msgbox "The update is complete" 10 40
