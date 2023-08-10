#!/bin/bash
POSTGRES_HOST=192.168.1.100
POSTGRES_ROOT_USERNAME=postgres
POSTGRES_ROOT_PASSWORD=mysecretpassword

AVNI_DB_USERNAME=openchs
AVNI_DB_PASSWORD=openchspassword
AVNI_DB_NAME=openchs

KEYCLOAK_DB_USERNAME=keycloak
KEYCLOAK_DB_PASSWORD=keycloakpassword
KEYCLOAK_DB_NAME=keycloak

AVNI_INTEGRATION_DB_USERNAME=avni_int
AVNI_INTEGRATION_DB_PASSWORD=avniintpassword
AVNI_INTEGRATION_DB_NAME=avni_int

echo "Creating Avni Database"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d postgres -c "create user ${AVNI_DB_USERNAME} with password '${AVNI_DB_PASSWORD}' createrole"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d postgres -c "create database ${AVNI_DB_NAME} with owner ${AVNI_DB_USERNAME}"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d ${AVNI_DB_NAME} -c 'create extension if not exists "uuid-ossp"'
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d ${AVNI_DB_NAME} -c 'create extension if not exists "ltree"'
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d ${AVNI_DB_NAME} -c 'create extension if not exists "hstore"'

echo "Restoring Avni Database"
gunzip -c ../backup_data/avni/avni_db_backup_19062023.sql.gz > ../backup_data/avni/avni_db_backup_19062023.sql
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -f ../backup_data/avni/avni_db_backup_19062023.sql

echo "Creating Keycloak Database"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d postgres -c "create user ${KEYCLOAK_DB_USERNAME} with password '${KEYCLOAK_DB_PASSWORD}' createrole"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d postgres -c "create database ${KEYCLOAK_DB_NAME} with owner ${KEYCLOAK_DB_USERNAME}"

echo "Restoring Keycloak Database"
gunzip -c ../backup_data/keycloak/keycloak_db_backup_19062023.sql.gz > ../backup_data/keycloak/keycloak_db_backup_19062023.sql
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d ${KEYCLOAK_DB_NAME} -f ../backup_data/keycloak/keycloak_db_backup_19062023.sql

echo "Creating Avni Integration Database"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d postgres -c "create user ${AVNI_INTEGRATION_DB_USERNAME} with password '${AVNI_INTEGRATION_DB_PASSWORD}' createrole"
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d postgres -c "create database ${AVNI_INTEGRATION_DB_NAME} with owner ${AVNI_INTEGRATION_DB_USERNAME}"

echo "Restoring Avni Integration Database"
gunzip -c ../backup_data/avni_integration/avni_integration_backup_10082023.sql.gz > ../backup_data/avni_integration/avni_integration_backup_10082023.sql
psql -h ${POSTGRES_HOST} -U ${POSTGRES_ROOT_USERNAME} -d ${AVNI_INTEGRATION_DB_NAME} -f ../backup_data/avni_integration/avni_integration_backup_10082023.sql

