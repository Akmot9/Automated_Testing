#!/bin/bash

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Server connection parameters
host="192.168.153.150"
port="22"
username="cyber"
password="admin"

# Local directory containing the script to copy
script="test.sh"
cwd=$(pwd)
script_path="$cwd/$script"
echo -e "${GREEN}Local path: $cwd${NC}"

# Remote directory to copy the script to
remote_path="Téléchargements/test"
echo -e "${GREEN}Remote path: $remote_path${NC}"

# Connect to the remote server
echo "Connecting to remote server..."
if sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "mkdir -p ~/$remote_path"; then
    echo -e "${GREEN}Remote directory created.${NC}"
else
    echo -e "${RED}Failed to create remote directory.${NC}"
    exit 1
fi

# Copy the script to the remote server
echo "Copying script to remote server..."
if sshpass -p "$password" scp "$script_path" "$username"@"$host":"$remote_path"; then
    echo -e "${GREEN}Script copied to remote server.${NC}"
else
    echo -e "${RED}Failed to copy script to remote server.${NC}"
    exit 1
fi

# Grant execute permission to the script on the remote server
echo "Granting execution permission to remote script..."
if sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "chmod +x ~/$remote_path/$script"; then
    echo -e "${GREEN}Permission granted to execute script.${NC}"
else
    echo -e "${RED}Failed to grant permission to execute script.${NC}"
    exit 1
fi

# Execute the script on the remote server
echo "Executing script on remote server..."
if sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "cd $remote_path && ./$script"; then
    echo -e "${GREEN}Script executed successfully.${NC}"
else
    echo -e "${RED}Failed to execute script.${NC}"
    exit 1
fi

# Copy files from the remote server to the local directory
echo "Copying results from remote server to local directory..."
if sshpass -p "$password" scp -r "$username"@"$host":"$remote_path" "$cwd"; then
    echo -e "${GREEN}Files copied from remote server to local directory.${NC}"
else
    echo -e "${RED}Failed to copy files from remote server to local directory.${NC}"
    exit 1
fi

echo -e "${GREEN}\n                Finished!${NC}"

# Close the SSH connection
sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$username"@"$host" -p "$port" "exit"
