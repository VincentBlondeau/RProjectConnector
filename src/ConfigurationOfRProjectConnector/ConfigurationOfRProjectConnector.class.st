"
A ConfigurationOfRProjectConnector is genrated with versionner.

Instance Variables
	project:		<Object>

project
	- xxxxx

"
Class {
	#name : #ConfigurationOfRProjectConnector,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfRProjectConnector
}

{ #category : #'development support' }
ConfigurationOfRProjectConnector class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfRProjectConnector class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfRProjectConnector class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfRProjectConnector class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfRProjectConnector class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfRProjectConnector class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfRProjectConnector class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfRProjectConnector class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfRProjectConnector class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfRProjectConnector class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfRProjectConnector >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'First version of the RConnector, a binding to R from Pharo'.
		spec author: 'VincentBLondeau'.
		spec timestamp: '12/5/2014 15:37'.
		spec repository: 'http://smalltalkhub.com/mc/VincentBlondeau/RProjectConnector/main/'.
		spec package: 'RConnector'.
		spec group: 'Core' with: #('RConnector' ). ].

]

{ #category : #catalog }
ConfigurationOfRProjectConnector >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ '- 1.0 - 05 dec 2014 - first release: execution of simple functions and types
[[[
	ConfigurationOfRProjectConnector project version: ''1.0'' ) load					
]]]'
]

{ #category : #catalog }
ConfigurationOfRProjectConnector >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'RProjectConnector is the first R project connector for Pharo with NativeBoost. You can get in contact with our great RProjectConnector programmer at vincent.blondeau@polytech-lille.net'
]

{ #category : #catalog }
ConfigurationOfRProjectConnector >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'RProjectConnector is the first R project connector for Pharo with NativeBoost. It is using the standard R libs to execute your functions and get the result under Pharo objects. You can even show the graphs that you have in R.'
]

{ #category : #catalog }
ConfigurationOfRProjectConnector >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'RConnector is composed of one key class named ==RObject==. There is also ==RFunction== and ==RVector==
- ==RObject== is the responsible for representing any R external object. 
- ==RFunction== is able to create and execute R function with non named parameters
- ==RVector== and it subclasses are some types mostly obtained after the evaluation of a RFunction. As they extend OrderedCollection, you can interract easily with them.'
]

{ #category : #catalog }
ConfigurationOfRProjectConnector >> catalogKeywords [
	"Returns an array of symbols"
	^ #(R NativeBoost Statistics Binding Connector) 
]

{ #category : #accessing }
ConfigurationOfRProjectConnector >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfRProjectConnector >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfRProjectConnector >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfRProjectConnector >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0'.

]

{ #category : #versions }
ConfigurationOfRProjectConnector >> version10: spec [
	<version: '1.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'VincentBLondeau'.
		spec timestamp: '12/5/2014 15:38'.
		spec package: 'RConnector' with: 'RConnector-VincentBLondeau.40'. ].

]
