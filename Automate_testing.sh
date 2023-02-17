#!/bin/bash

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Paramètres de connexion au serveur distant
host="192.168.153.150"
port="22"
username="cyber"
password="admin"

# Répertoire local contenant le logiciel à copier
cwd=$(pwd)
script_path="$cwd/test.sh"
echo -e "${GREEN}Local path: $cwd${NC}"

# Répertoire distant où copier le logiciel
remote_path="Téléchargements/test"
echo -e "${GREEN}Remote path: $remote_path${NC}"

# Connexion au serveur distant
echo "Connecting to remote server..."
if sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "mkdir -p ~/$remote_path"; then
    echo -e "${GREEN} Remote directory created.${NC}"
else
    echo -e "${RED} Failed to create remote directory.${NC}"
    exit 1
fi

# Copie du logiciel sur le serveur distant
echo "Copying script to remote server..."
if sshpass -p "$password" scp "$script_path" "$username"@"$host":"$remote_path"; then
    echo -e "${GREEN} Script copied to remote server.${NC}"
else
    echo -e "${RED} Failed to copy script to remote server.${NC}"
    exit 1
fi

# Donner la permission d'exécution au fichier "test.sh"
echo "Granting execution permission to remote script..."
if sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "chmod +x ~/Téléchargements/test/test.sh"; then
    echo -e "${GREEN} Permission granted to execute script.${NC}"
else
    echo -e "${RED} Failed to grant permission to execute script.${NC}"
    exit 1
fi

# Exécution du logiciel sur le serveur distant
echo "Executing script on remote server..."
if sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "cd $remote_path && ./test.sh"; then
    echo -e "${GREEN} Script executed successfully.${NC}"
else
    echo -e "${RED} Failed to execute script.${NC}"
    exit 1
fi

# Copie des fichiers depuis le serveur distant vers le répertoire local
echo "Copying results from remote server to local directory..."
if sshpass -p "$password" scp -r "$username"@"$host":"$remote_path" "$cwd"; then
    echo -e "${GREEN} Files copied from remote server to local directory.${NC}"
else
    echo -e "${RED} Failed to copy files from remote server to local directory.${NC}"
    exit 1
fi

echo -e "${GREEN}\n                Finished !${NC}"

# Fermeture de la connexion SSH
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "exit"
