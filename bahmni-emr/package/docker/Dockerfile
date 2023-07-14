FROM bahmniindiadistro/openmrs:latest

# Copy Inventory Modules downloaded by bahmni-emr/distro
COPY bahmni-emr/distro/target/distro/openhmis.backboneforms*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/distro/target/distro/openhmis.commons*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/distro/target/distro/openhmis.inventory*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/distro/target/distro/jasperreport*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/distro/target/distro/hwcinventory*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/

# Replace FHIR2 Extension Module
#TODO: Remove this once product image is upgraded with latest FHIR2 Extension Module
RUN rm -f ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/fhir2Extension-*.omod
COPY bahmni-emr/distro/target/distro/fhir2Extension-*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
