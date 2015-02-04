"
A RConnectorTest contains the tests for the statup and the installation of libs
"
Class {
	#name : #RSessionTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #tests }
RSessionTest >> testIfSessionIsValid [
	"If this test is not working, it means that the RConnector can be used because the session is not initialized"
	RSession checkWorking.
]

{ #category : #tests }
RSessionTest >> testInstallPackageShouldWork [
	"	arg = list(tseries,repos=http://cran.rstudio.com/)
		do.call(install.packages,arg)"

	| res |
	self fail.
	RFunction
		eval: 'install.packages'
		withParameters:
			{(RList new
				add: 'tseries';
				addAt: 'repo' value: 'http://cran.rstudio.com/';
				yourself)}.
	res := RFunction eval: 'library' withParameters: {'forecast'}.
	self assert: res value equals: 'forecast'
]

{ #category : #tests }
RSessionTest >> testLoadLibraryShouldNotWorkIfThePackageIsNotInstalled [
	self should: [ RFunction eval: 'library' withParameters: {'MARSS'} ] raise: REvaluationError  whoseDescriptionIncludes:  'MARSS'  description: 'Be sure that the evaluation error is because of the package and not something else'
]
