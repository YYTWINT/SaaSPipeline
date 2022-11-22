#!/bin/bash

if [ $# -ne 4 ]
then
        echo "stage_and_deploy_artifacts.sh called with incorrect number of arguments."
        echo "stage_and_deploy_artifacts.sh <unitPaht> <StageBaseDir> <CustomerArtifactDir> <DeployFlag>"
        echo "For example; stage_and_deploy_artifacts.sh /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<LNX_STAGE_DIR> <Artifacts> true/false"
        exit 1
fi

echo "Executing stage_and_deploy_artifacts.sh..."

UNIT_PATH=$1
STAGE_BASE_DIR=$2
CUSTOMER_ARTIFACTS_DIR=$3
EXECUTE_DEPLOY=$4

INIT_DEF_FILE=${UNIT_PATH}/init.def
stringarray=(`grep DMS_PARENT_BASELINE ${INIT_DEF_FILE} || { exit 1;}`)
RELEASE_IP=${stringarray[1]}
orig=${RELEASE_IP}
IFS=. read -r nxVersion IP <<< ${RELEASE_IP}

#############################################
#Linux Staging
#############################################

LNX_STAGE_DIR=${STAGE_BASE_DIR}/lnx64/TranslatorBinaries/
LNX_SOURCE_PATH=${UNIT_PATH}/lnx64/Products/TranslatorWorker

if [ ! -d ${LNX_STAGE_DIR} ]
then
	echo "Creating staging directory ${LNX_STAGE_DIR}"
	mkdir -p ${LNX_STAGE_DIR} || { exit 1;}
	chmod -R 0777 ${LNX_STAGE_DIR} || { exit 1;}
fi

# Copy all 
cp -r ${LNX_SOURCE_PATH}/*   ${LNX_STAGE_DIR}/ || { exit 1;}

# Then remove selected iteams
rm -rf ${LNX_STAGE_DIR}/debug || { exit 1;}
rm -rf ${LNX_STAGE_DIR}/license || { exit 1;}
rm -rf ${LNX_STAGE_DIR}/dockerfile || { exit 1;}

CONFIG_FILE_MULTICAD=${LNX_STAGE_DIR}/tessUG_multicad.config
CONFIG_FILE_VIS=${LNX_STAGE_DIR}/tessUG_vis.config
RUN_UGTOPV_MULTICAD=${LNX_STAGE_DIR}/run_ugtopv_multicad
RUN_UGTOPV_VIS=${LNX_STAGE_DIR}/run_ugtopv_vis

cp -f ${CUSTOMER_ARTIFACTS_DIR}/lnx64/${nxVersion}/run_ugtopv_multicad ${RUN_UGTOPV_MULTICAD} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/lnx64/${nxVersion}/run_ugtopv_vis ${RUN_UGTOPV_VIS} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/lnx64/${nxVersion}/tessUG_multicad.config ${CONFIG_FILE_MULTICAD} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/lnx64/${nxVersion}/tessUG_vis.config ${CONFIG_FILE_VIS} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/lnx64/${nxVersion}/NXJT_Translator_README.txt ${STAGE_BASE_DIR}/lnx64/ || { exit 1;}

chmod 0755 ${CONFIG_FILE_MULTICAD} || { exit 1;}
chmod 0755 ${CONFIG_FILE_VIS} || { exit 1;}
chmod 0755 ${RUN_UGTOPV_MULTICAD} || { exit 1;}
chmod 0755 ${RUN_UGTOPV_VIS} || { exit 1;}

#############################################
#Windows Staging
#############################################

Win_STAGE_DIR=${STAGE_BASE_DIR}/wntx64/TranslatorBinaries/
Win_SOURCE_PATH=${UNIT_PATH}/wntx64/Products/TranslatorWorker

if [ ! -d ${Win_STAGE_DIR} ]
then
	echo "Creating staging directory ${Win_STAGE_DIR}"
	mkdir -p ${Win_STAGE_DIR} || { exit 1;}
	chmod -R 0777 ${Win_STAGE_DIR} || { exit 1;}
fi

# Copy all 
cp -r ${Win_SOURCE_PATH}/*   ${Win_STAGE_DIR}/ || { exit 1;}

# Then remove selected iteams
rm -rf ${Win_STAGE_DIR}/debug || { exit 1;}
rm -rf ${Win_STAGE_DIR}/license || { exit 1;}
rm -rf ${Win_STAGE_DIR}/dockerfile || { exit 1;}

CONFIG_FILE_MULTICAD_WIN=${Win_STAGE_DIR}/tessUG_multicad.config
CONFIG_FILE_VIS_WIN=${Win_STAGE_DIR}/tessUG_vis.config
RUN_UGTOPV_MULTICAD_WIN=${Win_STAGE_DIR}/run_ugtopv_multicad.bat
RUN_UGTOPV_VIS_WIN=${Win_STAGE_DIR}/run_ugtopv_vis.bat

cp -f ${CUSTOMER_ARTIFACTS_DIR}/wntx64/${nxVersion}/run_ugtopv_multicad.bat ${RUN_UGTOPV_MULTICAD_WIN} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/wntx64/${nxVersion}/run_ugtopv_vis.bat ${RUN_UGTOPV_VIS_WIN} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/wntx64/${nxVersion}/tessUG_multicad.config ${CONFIG_FILE_MULTICAD_WIN} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/wntx64/${nxVersion}/tessUG_vis.config ${CONFIG_FILE_VIS_WIN} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/wntx64/${nxVersion}/NXJT_Translator_README.txt ${STAGE_BASE_DIR}/wntx64/ || { exit 1;}

chmod 0755 ${CONFIG_FILE_MULTICAD_WIN} || { exit 1;}
chmod 0755 ${CONFIG_FILE_VIS_WIN} || { exit 1;}
chmod 0755 ${RUN_UGTOPV_MULTICAD_WIN} || { exit 1;}
chmod 0755 ${RUN_UGTOPV_VIS_WIN} || { exit 1;}

if [ ${EXECUTE_DEPLOY} == "true" ]
then
	
	releaseName=${orig//'.'/'_TranslatorWorker.'}
	############################################
	#Linux Deploy
	############################################
	echo "Deploy flag is set to true. Executing deploy step with release IP =${RELEASE_IP} in Linux..."
	cd ${STAGE_BASE_DIR}/lnx64 || { exit 1;}
	tar -czf $releaseName.tar.gz TranslatorBinaries/ || { exit 1;}
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	cd -
	
	############################################
	#Windows Deploy
	############################################
	echo "Deploy flag is set to true. Executing deploy step with release IP =${RELEASE_IP} in Windows..."
	cd ${STAGE_BASE_DIR}/wntx64 || { exit 1;}
	tar -czf $releaseName.tar.gz TranslatorBinaries/ || { exit 1;}
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	cd -
	
else
	echo "Deploy flag is set to false. Skipping deploy step..."
fi
