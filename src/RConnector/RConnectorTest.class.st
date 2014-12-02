Class {
	#name : #RConnectorTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RConnectorTest >> testIfSessionIsValid [
	"If this test is not working, it means that the RConnector can be used because the session is not initialized"
	RSession checkWorking.
]

{ #category : #'as yet unclassified' }
RConnectorTest >> testInstallPackageShouldWork [
"	arg = list(""tseries"",repos=""http://cran.rstudio.com/"")
	do.call(install.packages,arg)"
	|  res |
	self fail.
	RFunction eval: 'install.packages' withParameters: { (RList new: 2) first: 'tseries'; second: 'repo=http://cran.rstudio.com/'; yourself }.
	res := RFunction eval: 'library' withParameters: {'forecast'}.
	self assert: res value equals: 'forecast'
	
	
	
	
]

{ #category : #'as yet unclassified' }
RConnectorTest >> testLoadLibraryShouldNotWorkIfThePackageIsNotInstalled [
	self should: [ RFunction eval: 'library' withParameters: {'forecast'} ] raise: REvaluationError
]
