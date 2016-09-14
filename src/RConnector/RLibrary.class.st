"
I represent the libray path that should be used for the R connector.
This should be filled and extebded by the users and commited into the repository
"
Class {
	#name : #RLibrary,
	#superclass : #FFILibrary,
	#category : #'RConnector-Core'
}

{ #category : #'accessing platform' }
RLibrary >> macModuleName [
	self flag: 'Should be filled afterward'.
	#('/usr/local/Cellar/r/3.3.1_2/R.framework/Versions/3.3/Resources/lib/R.dylib'
	"Put other libs locations here!! ;)"
	)
		do: [ :path | 
			path asFileReference exists
				ifTrue: [ ^ path ] ].
	self error: 'Cannot locate cairo library. Please check if it installed on your system'
]

{ #category : #'accessing platform' }
RLibrary >> unixModuleName [
	self flag: 'Should be filled by a unix user ;)'.
	self shouldBeImplemented 
]

{ #category : #'accessing platform' }
RLibrary >> win32ModuleName [ 
	self flag: 'can be automatised by looking into the system registry'.
	^ 'R.dll'
]
