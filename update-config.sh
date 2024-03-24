#!/bin/bash
git pull

# this script is located at the root of the project
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
items=$(ls -d */ | sed 's/\///g')
# print items

while choice=$(dialog --title "Select your printer" \
    --menu "Choose one of the following options:" 15 55 5 \
    $items 3>&1 1>&2 2>&3)
  do
    echo $choice
  break
done