import paramiko
import os
import scp
import time

# Paramètres de connexion au serveur distant
host = '192.168.153.150'
port = 22
username = 'cyber'
password = 'admin'

# Répertoire local contenant le logiciel à copier
cwd = os.getcwd()
local_path = os.path.join(cwd, 'test.sh')
print(local_path)

# Répertoire distant où copier le logiciel
remote_path = 'Téléchargements/test'

# Connexion au serveur distant
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, port=port, username=username, password=password)

# Création du dossier "test" dans le répertoire distant
command = 'mkdir ~/Téléchargements/test'
test_folder= 'Téléchargements/test'
stdin, stdout, stderr = ssh.exec_command(command)

# Copie du logiciel sur le serveur distant
with scp.SCPClient(ssh.get_transport()) as scp_client:
    scp_client.put(local_path, remote_path)

# Donner la permission d'exécution au fichier "test.sh"
command = 'chmod +x ~/Téléchargements/test/test.sh'
stdin, stdout, stderr = ssh.exec_command(command)

# Exécution du logiciel sur le serveur distant
stdin, stdout, stderr = ssh.exec_command('cd ' + remote_path + ' && ./test.sh')
print('Executing...')

# Check if the script is still running
while not stdout.channel.exit_status_ready():
    try:
        output = stdout.read().decode()
        print(output)
        time.sleep(1)
    except paramiko.SSHException:
        print("Error occurred while reading SSH output.")
        break

# Copie des fichiers depuis le serveur distant vers le répertoire local
print(test_folder)
print(local_path)
with scp.SCPClient(ssh.get_transport()) as scp_client:
    scp_client.get(test_folder, local_path, recursive=True)

print("Finished")

# Fermeture de la connexion SSH
ssh.close()
