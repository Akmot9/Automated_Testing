#!/bin/bash

# Wait for 20 seconds
sleep 10

# Get the current date and time
now=$(date +"%Y-%m-%d %H:%M:%S")

# Write the date to three different files
echo $now > file1.csv
echo $now > file2.json
echo $now > file3.log
