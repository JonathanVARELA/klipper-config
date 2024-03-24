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

# Select a printer config file
printers=$(ls -d */ | sed 's/\///g')

select printer in $printers; do
    if [ -n "$printer" ]; then
        echo "You selected: $printer"
        # Check if the folder with the same name exists in the home directory
        if [ ! -d ~/$printer ]; then
            echo "Creating folder ~/$printer"
            mkdir ~/$printer
        fi
        # Check if the file printer.cfg exists in the folder ~/
        if [ ! -f ~/printer.cfg ]; then
            echo "Copying printer.cfg to ~/$printer"
            cp $printer/printer.cfg ~/printer.cfg
        fi
        # Check if the folder config exists in the folder ~/$printer
        if [ ! -d ~/$printer/config ]; then
            echo "Creating folder ~/$printer/config"
            mkdir ~/$printer/config
        fi
        # Clear the contents of the folder ~/$printer/config
        echo "Clearing the contents of ~/$printer/config"
        rm -rf ~/$printer/config/*
        # Copy the contents of the project config folder to the newly created config folder
        echo "Copying the contents of $printer/config to ~/$printer/config"
        cp -r $printer/config/* ~/$printer/config/
        echo "Update complete"
        break
    else
        echo "Invalid selection"
    fi
done