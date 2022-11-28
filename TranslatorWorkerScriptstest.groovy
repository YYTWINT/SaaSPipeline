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
		bat """ ./Scripts/wntx64/createTranslatorWorkerUnittest.bat ${params.NXRelease} ${unitFullPath} ${params.HC} """			
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
		bat """ ./Scripts/wntx64/buildTranslatorWorkerUnittest.bat ${unitFullPath} ${params.CPNumber} ${params.HC} """	
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
		bat """ ./Scripts/wntx64/executeTranslatorWorkerTest.bat ${unitFullPath} """
	}
}

def LinuxStageAndCopy(String buildDir, String stageDir)
{
	echo "Executing stage and deploy..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		
		sh "chmod +x ./Scripts/lnx64/stageAndcopy.sh "
		sh "./Scripts/lnx64/stageAndcopy.sh ${unitFullPath} ${stagePath} 'Artifacts'"		
	}
}

def WinStageAndCopy(String buildDir, String stageDir)
{
	echo "Executing stage and deploy..."
	script{		
		def unitFullPath="${buildDir}"
		def stagePath="${stageDir}"
		
		bat """ ./Artifacts/wntx64/stageAndcopy.bat ${unitFullPath} ${stagePath} 'Artifacts'"		
	}
}

def DeployProcess(String buildDir)
{
	echo "Executing deploy..."
	script{		
		def unitFullPath="${buildDir}"
		def deployFlag="${params.Deploy}"
		
		sh "chmod +x ./Scripts/lnx64/DeployTranslatorWorkerUnit.sh"
		sh "./Scripts/lnx64/DeployTranslatorWorkerUnit.sh ${unitFullPath} ${deployFlag}"			
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
