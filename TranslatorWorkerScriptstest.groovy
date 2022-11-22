def createUnit(String buildDir)
{
	echo "Creating unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/lnx64/createTranslatorWorkerUnittest.sh "
		sh "./Scripts/lnx64/createTranslatorWorkerUnittest.sh ${params.NXRelease} ${unitFullPath} ${params.HC}"		
	}
}

def buildUnit(String buildDir)
{
	echo "Building unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/lnx64/buildTranslatorWorkerUnittest.sh "
		sh "./Scripts/lnx64/buildTranslatorWorkerUnittest.sh ${unitFullPath} ${params.CPNumber} ${params.HC}"		
	}
}

def TestUnit(String buildDir)
{
	echo "Executing devtests..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/lnx64/executeTranslatorWorkerTest.sh "
		sh "./Scripts/lnx64/executeTranslatorWorkerTest.sh ${unitFullPath}"		
	}
}

def StageAndDeploy(String buildDir, String stageDir)
{
	echo "Executing stage and deploy..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		def deployFlag="${params.Deploy}"
		
		sh "chmod +x ./Scripts/lnx64/stageAndDeployTranslatorWorkerUnit.sh "
		sh "./Scripts/lnx64/stageAndDeployTranslatorWorkerUnit.sh ${unitFullPath} ${stagePath} 'Artifacts' ${deployFlag}"		
	}
}

def Purge(String dirName)
{
	echo "Executing Purge ..."
	script{		
		def fullPath="${dirName}"
		sh "chmod +x ./Scripts/lnx64/purge.sh "
		sh "./Scripts/lnx64/purge.sh ${fullPath}"		
	}
}

return this
