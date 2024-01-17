#!/bin/bash

if [[ $CKAN__PLUGINS == *" harvest "* ]]; then
   # Check that Harvester settings have been configured in the .env file
   ckan -c $CKAN_INI db upgrade -p harvest

else
   echo "Not configuring Harvester"
fi
