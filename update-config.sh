#!/bin/bash

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

# update the printer config file function
update_config() {
  printer=$1

  echo "You selected: $printer"
  # Check if the folder with the same name exists in the home directory
  if [ ! -d ~/printer_data/config/"$printer" ]; then
      echo "Creating folder ~/printer_data/config/$printer"
      mkdir ~/printer_data/config/"$printer"
  fi
  # Check if the file printer.cfg exists in the folder ~/
  if [ ! -f ~/printer_data/config/printer.cfg ]; then
      echo "Copying printer.cfg to ~/printer_data/config"
      cp "$printer"/printer.cfg ~/printer_data/config/printer.cfg
  fi
  # Check if the folder config exists in the folder ~/printer_data/config/$printer
  if [ ! -d ~/printer_data/config/"$printer" ]; then
      echo "Creating folder ~/printer_data/config/$printer"
      # shellcheck disable=SC2086
      mkdir ~/printer_data/config/$printer
  fi
  # Clear the contents of the folder ~/printer_data/config/$printer/config
  echo "Clearing the contents of ~/printer_data/config/$printer/config"
  rm -rf ~/printer_data/config/"$printer"/*
  # Copy the contents of the project config folder to the newly created config folder
  echo "Copying the contents of $printer/config to ~/printer_data/config/$printer/config"
  cp -r "$printer"/config/* ~/printer_data/config/"$printer"/
  echo "Update complete"
}

# Select a printer config file
printers=$(ls -d */ | sed 's/\///g')

# if only one printer is available, select it automatically
if [ "$(echo "$printers" | wc -l)" -eq 1 ]; then
  update_config "$printers"
else
  echo "Select the printer to update:"
  PS3="Selected printer: "
  select printer in $printers; do
    if [ -n "$printer" ]; then
      update_config "$printer"
      break
    else
      echo "Invalid selection"
    fi
  done
fi