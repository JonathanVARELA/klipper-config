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

while [ choice=$(dialog --title "Select your printer" \
  --menu "Choose one of the following printer:" 10 40 3 \
  "${items[@]}" \
  2>&1 >/dev/tty
) ]; do
  # echo $choice
  # Check if the folder with the same name exists in the home directory
  if [ ! -d ~/$choice ]; then
    mkdir ~/$choice
  fi
  # Check if the file printer.cfg exists in the folder ~/
  if [ ! -f ~/$choice/printer.cfg ]; then
    cp $choice/printer.cfg ~/$choice/printer.cfg
  fi
  # Check if the folder config exists in the folder ~/a10m
  if [ ! -d ~/$choice/config ]; then
    mkdir ~/$choice/config
  fi
  # Clear the contents of the folder ~/a10m/config
  rm -rf ~/$choice/config/*
  # Copy the contents of the project config folder to the newly created config folder
  cp -r $choice/config/* ~/$choice/config/
  # Send a message to the user that the update is complete
  dialog --title "Update complete" --msgbox "The update is complete" 10 40
  break
