import paramiko
import os
import scp

# Paramètres de connexion au serveur distant
host = '192.168.153.150'
port = 22
username = 'cyber'
password = 'admin'

# Répertoire local contenant le logiciel à copier
cwd = os.getcwd()
local_path = cwd+'\\test.sh'
print(local_path)

# Répertoire distant où copier le logiciel
remote_path = 'Téléchargements/test'


# Connexion au serveur distant
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, port=port, username=username, password=password)

# Création du dossier "test" dans le répertoire distant
command = 'mkdir ~/Téléchargements/test'
stdin, stdout, stderr = ssh.exec_command(command)
print(stdin)

# Copie du logiciel sur le serveur distant
with scp.SCPClient(ssh.get_transport()) as scp_client:
    scp_client.put(local_path, remote_path)

# Donner la permission d'exécution au fichier "test.sh"
command = 'chmod +x ~/Téléchargements/test/test.sh'
stdin, stdout, stderr = ssh.exec_command(command)

# Exécution du logiciel sur le serveur distant
stdin, stdout, stderr = ssh.exec_command('cd ' + remote_path + ' && ./test.sh')
print(stdin)
