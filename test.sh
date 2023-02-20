#!/bin/bash

# Get the current date and time
now=$(date +"%Y-%m-%d %H:%M:%S")

i=$(uname -a)
echo "now : $now"
echo "i : $i"

# Prompt the user for the option to choose
printf "Voulez vous faire un :\n    1. relevé date\n    2. relevé infos\n    3. Les deux\nChoisissez 1/2/3: "
read option

# Prompt the user for the second option to choose
printf "Voulez vous faire un :\n    1. relevé json\n    2. relevé de csv\n    3. Les deux\nChoisissez 1/2/3: "
read option2

# Prompt the user for three letters
read -p "Entrez trois lettres: " lettres

# Prompt the user for two letters
read -p "Entrez deux lettres: " lettres2

# Prompt the user for six numbers
read -p "Entrez six chiffres: " chiffres

echo "Vous avez choisi l'option $option et l'option $option2."
echo "Les lettres que vous avez entrées sont $lettres et $lettres2."
echo "Les chiffres que vous avez entrés sont $chiffres."

name="${lettres}_${lettres2}_${chiffres}"

if [ $option -eq 1 ]
then
  infos="${now}"
elif [ $option -eq 2 ]
then
  infos="${i} ${lettres} ${lettres2} ${chiffres}"
else
  infos="${i} ${now} ${lettres} ${lettres2} ${chiffres}"
fi

if [ $option2 -eq 1 ]
then
  # Wait for 10 seconds
  sleep 10
  echo $infos > $name.json
  echo $infos > $name.log
elif [ $option2 -eq 2 ]
then
  # Wait for 10 seconds
  sleep 10
  echo $infos > $name.csv
  echo $infos > $name.log
else
  # Wait for 10 seconds
  sleep 10
  echo $infos > $name.csv
  echo $infos > $name.json
  echo $infos > $name.log
fi
