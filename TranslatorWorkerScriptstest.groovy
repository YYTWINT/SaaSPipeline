def createLinuxUnit(String buildDir)
{
	echo "Creating unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/lnx64/createTranslatorWorkerUnittest.sh "
		sh "./Scripts/lnx64/createTranslatorWorkerUnittest.sh ${params.NXRelease} ${unitFullPath} ${params.HC}"		
	}
}
def createWindowUnit(String buildDir)
{
	echo "Creating unit..."
	script{		
		def unitFullPath="${buildDir}"
		bat """ "./Scripts/wntx64/createTranslatorWorkerUnittest.bat ${params.NXRelease} ${unitFullPath} ${params.HC} """			
	}
}

def buildLinuxUnit(String buildDir)
{
	echo "Building Linux unit..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/lnx64/buildTranslatorWorkerUnittest.sh "
		sh "./Scripts/lnx64/buildTranslatorWorkerUnittest.sh ${unitFullPath} ${params.CPNumber} ${params.HC}"		
	}
}

def buildWinUnit(String buildDir)
{
	echo "Building Windows unit..."
	script{		
		def unitFullPath="${buildDir}"
		bat """ "./Scripts/wntx64/buildTranslatorWorkerUnittest.bat ${unitFullPath} ${params.CPNumber} ${params.HC} """	
	}
}

def TestLinuxUnit(String buildDir)
{
	echo "Executing Linux devtests..."
	script{		
		def unitFullPath="${buildDir}"
		sh "chmod +x ./Scripts/lnx64/executeTranslatorWorkerTest.sh "
		sh "./Scripts/lnx64/executeTranslatorWorkerTest.sh ${unitFullPath}"		
	}
}

def TestWinUnit(String buildDir)
{
	echo "Executing Windows devtests..."
	script{		
		def unitFullPath="${buildDir}"
		bat """ "./Scripts/wntx64/executeTranslatorWorkerTest.bat ${unitFullPath} """
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
