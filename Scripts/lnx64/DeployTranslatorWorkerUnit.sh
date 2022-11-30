#!/bin/bash

if [ $# -ne 2 ]
then
        echo "stageAndDeployTranslatorWorkerUnit.sh called with incorrect number of arguments."
        echo "stageAndDeployTranslatorWorkerUnit.sh <UnitPath> <StageDir> <ArtifactsDir> <DeployFlag>"
        echo "For example; stageAndDeployTranslatorWorkerUnit.sh /plm/pnnas/ppic/users/<unit_name> true/false"
        exit 1
fi

UNIT_PATH=$1
EXECUTE_DEPLOY=$2

INIT_DEF_FILE=${UNIT_PATH}/init.def
stringarray=(`grep DMS_PARENT_BASELINE ${INIT_DEF_FILE} || { exit 1;}`)
RELEASE_IP=${stringarray[1]}
orig=${RELEASE_IP}
IFS=. read -r nxVersion IP <<< ${RELEASE_IP}
releaseName=${orig//'.'/'_TranslatorWorker.'}
commonLocation=//plm/pnnas/ppic/Data_Exchange/SaaS_distributions/NXJT/${releaseName}/

if [ ${EXECUTE_DEPLOY} == "true" ]
then
	
	############################################
	#Linux Deploy
	############################################
	echo "Deploy flag is set to true. Executing deploy step with release IP =${RELEASE_IP} in Linux..."
	cd ${commonLocation}/lnx64 || { exit 1;}
	tar -czf $releaseName.tar.gz TranslatorBinaries/ || { exit 1;}
	
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"
	
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/">deployStep.txt

	echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/">>deployStep.txt
	
	cd -
	
	############################################
	#Windows Deploy- don't need for current artifacts
	############################################
	# echo "Deploy flag is set to true. Executing deploy step with release IP =${RELEASE_IP} in Windows..."
	# cd ${commonLocation}/wntx64 || { exit 1;}
	# tar -czf $releaseName.tar.gz TranslatorBinaries/ || { exit 1;}
	
	# echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"
	
	# echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/">deployStep.txt

	# echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	# echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/">>deployStep.txt
	
	# cd -
	
else
	echo "Deploy flag is set to false. Skipping deploy step..."
fi




