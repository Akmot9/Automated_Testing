#!/bin/bash

# Paramètres de connexion au serveur distant
host="192.168.153.150"
port="22"
username="cyber"
password="admin"

# Répertoire local contenant le logiciel à copier
cwd=$(pwd)
script_path="$cwd/test.sh"
echo "$local_path"

# Répertoire distant où copier le logiciel
remote_path="Téléchargements/test"
echo "$remote_path"

# Connexion au serveur distant
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "mkdir -p ~/$remote_path"

# Copie du logiciel sur le serveur distant
sshpass -p "$password" scp "$script_path" "$username"@"$host":"$remote_path"

# Donner la permission d'exécution au fichier "test.sh"
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "chmod +x ~/Téléchargements/test/test.sh"

# Exécution du logiciel sur le serveur distant
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "cd $remote_path && ./test.sh"
echo "Executing..."

# Copie des fichiers depuis le serveur distant vers le répertoire local
sshpass -p "$password" scp -r "$username"@"$host":"$remote_path" "$cwd"

echo "Finished"

# Fermeture de la connexion SSH
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "exit"
