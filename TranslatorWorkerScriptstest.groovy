def createUnit(String buildDir)
{
	echo "Creating unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/createTranslatorWorkerUnittest.sh "
		sh "./Scripts/createTranslatorWorkerUnittest.sh ${params.NXRelease} ${unitFullPath} ${params.HC}"		
	}
}

def buildUnit(String buildDir)
{
	echo "Building unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/buildTranslatorWorkerUnittest.sh "
		sh "./Scripts/buildTranslatorWorkerUnittest.sh ${unitFullPath} ${params.CPNumber} ${params.HC}"		
	}
}

def TestUnit(String buildDir)
{
	echo "Executing devtests..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/executeTranslatorWorkerTest.sh "
		sh "./Scripts/executeTranslatorWorkerTest.sh ${unitFullPath}"		
	}
}

def StageAndDeploy(String buildDir, String stageDir)
{
	echo "Executing stage and deploy..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		def deployFlag="${params.Deploy}"
		
		sh "chmod +x ./Scripts/stageAndDeployTranslatorWorkerUnit.sh "
		sh "./Scripts/stageAndDeployTranslatorWorkerUnit.sh ${unitFullPath} ${stagePath} 'Artifacts' ${deployFlag}"		
	}
}

def Purge(String dirName)
{
	echo "Executing Purge ..."
	script{		
		def fullPath="${dirName}"
		sh "chmod +x ./Scripts/purge.sh "
		sh "./Scripts/purge.sh ${fullPath}"		
	}
}

return this
