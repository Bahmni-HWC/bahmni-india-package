#!/bin/bash

# Set the backup folder path
backup_folder="."

# Get the current datetime
datetime=$(date +'%Y-%m-%d_%I-%M-%S-%p')

# Create the backup folder with the current datetime
backup_subfolder_full_path="$backup_folder/$datetime"
mkdir -p "$backup_subfolder_full_path"

# Set the backup file paths
mkdir -p "$backup_subfolder_full_path/openmrs"
mkdir -p "$backup_subfolder_full_path/reports"
mkdir -p "$backup_subfolder_full_path/avni"
mkdir -p "$backup_subfolder_full_path/keycloak"

backup_subfolder_openmrs_full_path=$backup_subfolder_full_path/openmrs/openmrsdb_backup.sql
backup_subfolder_reports_full_path=$backup_subfolder_full_path/reports/reportsdb_backup.sql
backup_subfolder_avni_full_path=$backup_subfolder_full_path/avni/avni_db_backup.sql
backup_subfolder_avni_integration_full_path=$backup_subfolder_full_path/avni/avni_integration_db_backup.sql
backup_subfolder_keycloak_full_path=$backup_subfolder_full_path/keycloak/keycloak_db_backup.sql
backup_subfolder_minio_full_path=$backup_subfolder_full_path/avni/minio

source ../.env.prod

patient_documents_container="patient-documents"
patient_images_container="proxy"
minio_container="minio"

echo "Taking backup for OpenMRS"
mysqldump -h $OPENMRS_DB_HOST -u $OPENMRS_DB_USERNAME --password=$OPENMRS_DB_PASSWORD --routines openmrs > "$backup_subfolder_openmrs_full_path" --no-tablespaces

echo "Taking backup for Reports"
mysqldump -h $REPORTS_DB_HOST -u $REPORTS_DB_USERNAME --password=$REPORTS_DB_PASSWORD --routines bahmni_reports > "$backup_subfolder_reports_full_path" --no-tablespaces

echo "Taking backup for Patient-Documents and Uploaded lab results"
docker cp -a $patient_documents_container:/usr/share/nginx/html/document_images "$backup_subfolder_full_path"
docker cp -a $patient_documents_container:/usr/share/nginx/html/uploaded_results "$backup_subfolder_full_path"

echo "Taking backup for Patient-Images"
docker cp -a $patient_images_container:/home/bahmni/patient_images "$backup_subfolder_full_path"

echo "Taking backup for Avni"
pg_dump -h $AVNI_DB_HOST -U $AVNI_DB_USERNAME -d $AVNI_DB_NAME -F c -b -v -f "$backup_subfolder_avni_full_path"

echo "Taking backup for Avni Integration"
pg_dump -h $AVNI_INTEGRATION_DB_HOST -U $AVNI_INTEGRATION_DB_USER -d $AVNI_INTEGRATION_DB_NAME -F c -b -v -f "$backup_subfolder_avni_integration_full_path"

echo "Taking backup for Keycloak"
pg_dump -h $KEYCLOAK_DB_HOST -U $KEYCLOAK_DB_USERNAME -d $KEYCLOAK_DB_NAME -F c -b -v -f "$backup_subfolder_keycloak_full_path"

echo "Taking backup for Minio"
docker cp -a $minio_container:/data "$backup_subfolder_minio_full_path"

echo "Backup completed successfully"