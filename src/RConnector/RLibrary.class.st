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
	#('/usr/local/Cellar/r/3.3.1_2/R.framework/Versions/3.3/Resources/lib/R.dylib' 'R.dylib')
		do: [ :path | 
			path asFileReference exists
				ifTrue: [ ^ path ] ].
	"Put other libs locations here!! ;)"
	^ #R	"default value"
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
