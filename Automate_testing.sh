#!/bin/bash

# Paramètres de connexion au serveur distant
host='192.168.153.150'
port=22
username='cyber'
password='admin'

# Répertoire local contenant le logiciel à copier
cwd=$(pwd)
local_path="$cwd/test.sh"
echo "$local_path"

# Répertoire distant où copier le logiciel
remote_path='Téléchargements/test'

# Connexion au serveur distant
sshpass -p "$password" ssh -o StrictHostKeyChecking=no $username@$host -p $port << EOF
# Création du dossier "test" dans le répertoire distant
mkdir ~/Téléchargements/test

# Copie du logiciel sur le serveur distant
scp -P $port $local_path $username@$host:~/$remote_path

# Donner la permission d'exécution au fichier "test.sh"
chmod +x ~/Téléchargements/test/test.sh

# Exécution du logiciel sur le serveur distant
cd $remote_path && ./test.sh

EOF
