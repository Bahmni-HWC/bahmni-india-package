FROM bahmniindiadistro/openmrs:latest

COPY bahmni-emr/resources/openhmis.backboneforms*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/resources/openhmis.commons*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/resources/openhmis.inventory*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
COPY bahmni-emr/resources/jasperreport*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/

# Replace FHIR2 Extension Module
#TODO: Remove this once product image is upgraded with latest FHIR2 Extension Module
RUN rm -f ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/fhir2Extension-*.omod
COPY distro/target/distro/fhir2Extension-*.omod ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules/
