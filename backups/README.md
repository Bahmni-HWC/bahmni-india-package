# Backup Script:
## This bash script takes backups of the OpenMRS, Reports databases using mysqldump, Keycloak, Avni, Avni-integration using pd_dump and copies Patient Documents, Images and Minio from their respective Docker containers to a backup directory.

## Usage

1. Open a terminal and navigate to the directory where the script is located.
2. Open the script file (backup.sh) in a text editor and customize the configuration variables according to your setup:
    backup_folder: Specify the path to the folder where you want to store the backups. By default, it is set to the current directory.
    Set the `container` names to the ones you are using with there respective db username and password
3. Save the changes to the script file.
4. In the terminal, navigate to the directory where the script is located.
5. Make the script executable:
    chmod +x backup.sh
6. Run the script by executing the following command:
    ./backup.sh

The script will start taking backups of the specified components and save them in the designated backup folder.
After the script finishes running, you will find the backup files and directories in the backup folder.