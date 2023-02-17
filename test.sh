#!/bin/bash

# Get the current date and time
now=$(date +"%Y-%m-%d %H:%M:%S")

printf "Voulez vous faire un :\n    1.  relevé json  \n    2.  relevé de csv \n    3.  Les deux\n"
  printf "Choisissez 1/2/3\n"
  read Y
  if [ $Y -eq 1 ]
  then
    # Wait for 20 seconds
    sleep 10
    echo $now > file2.json
    echo $now > file3.log
    #printf $z
  elif [ $Y -eq 2 ]
  then
    # Wait for 20 seconds
    sleep 10
    echo $now > file1.csv
    echo $now > file3.log
    #printf $z
  else
    # Wait for 20 seconds
    sleep 10
    # Write the date to three different files
    echo $now > file1.csv
    echo $now > file2.json
    echo $now > file3.log
    #printf $z
  fi







