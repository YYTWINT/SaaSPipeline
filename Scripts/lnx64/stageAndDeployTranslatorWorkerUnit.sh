#!/bin/bash

if [ $# -ne 4 ]
then
        echo "stageAndDeployTranslatorWorkerUnit.sh called with incorrect number of arguments."
        echo "stageAndDeployTranslatorWorkerUnit.sh <UnitPath> <StageDir> <ArtifactsDir> <DeployFlag>"
        echo "For example; stageAndDeployTranslatorWorkerUnit.sh /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<stage_dir> <ArtifactsDir> true/false"
        exit 1
fi

UNIT_PATH=$1
STAGE_BASE_DIR=$2
ARTIFACTS_DIR=$3
EXECUTE_DEPLOY=$4

# Run customer specific stage script to stage artifacts
chmod 0755 ${ARTIFACTS_DIR}/lnx64/stage_and_deploy_artifacts.sh || { exit 1;}
${ARTIFACTS_DIR}/lnx64/stage_and_deploy_artifacts.sh ${UNIT_PATH} ${STAGE_BASE_DIR} ${ARTIFACTS_DIR} ${EXECUTE_DEPLOY} || { exit 1;}



