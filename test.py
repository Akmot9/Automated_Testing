import paramiko
import os
import scp

# Paramètres de connexion au serveur distant
host = 'example.com'
port = 22
username = 'user'
password = 'admin'

# Répertoire local contenant le logiciel à copier
local_path = '/chemin/vers/mon/logiciel'

# Répertoire distant où copier le logiciel
remote_path = '~/'



# Connexion au serveur distant
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, port=port, username=username, password=password)

# Copie du logiciel sur le serveur distant
with scp.SCPClient(ssh.get_transport()) as scp_client:
    scp_client.put(local_path, remote_path)



# Exécution du logiciel sur le serveur distant
stdin, stdout, stderr = ssh.exec_command('cd ' + remote_path + ' && ./nom-du-logiciel')



# Récupération des fichiers créés par le logiciel
remote_files = []
sftp = ssh.open_sftp()
for filename in sftp.listdir(remote_path):
    if filename.startswith('prefixe-des-fichiers-cree-par-le-logiciel'):
        remote_files.append(filename)
        sftp.get(os.path.join(remote_path, filename), os.path.join(local_path, filename))
sftp.close()

# Fermeture de la connexion SSH
ssh.close()