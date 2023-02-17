#!/bin/bash

# Wait for 20 seconds
sleep 20

# Get the current date and time
now=$(date +"%Y-%m-%d %H:%M:%S")

# Write the date to three different files
echo $now > file1.txt
echo $now > file2.txt
echo $now > file3.txt
