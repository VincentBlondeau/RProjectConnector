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

{ #category : #doits }
ConfigurationOfRProjectConnector >> copyRWinLibs: rPath [
	" Private - Copy detected R DLL's in rPath to VM directory "

	| vmPath dlls |
	vmPath := Smalltalk vmDirectory asFileReference.
	dlls := (rPath asFileReference / 'bin' / 'i386') entries
		select: [ : entry | entry  extension = 'dll' ]
		thenDo: [ : dllEntry | dllEntry asFileReference copyTo: vmPath / dllEntry basename ].
	dlls notEmpty ifTrue: [ Transcript show: 'Successfully copied R dll''s to VM path'; cr ]
]

{ #category : #accessing }
ConfigurationOfRProjectConnector >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #doits }
ConfigurationOfRProjectConnector >> detectRWinInstallation [

	| rPath  winRegistry |
	winRegistry := Smalltalk at: #WinRegistry.
	(rPath := winRegistry
	    queryValue: 'InstallPath'
	    fromKey: (winRegistry localMachine queryOpenSubkey: 'Software\\R-core\\R')) notNil
			ifTrue: [ self copyRWinLibs: rPath ]
			ifFalse: [ Transcript show: 'R was not detected in Windows Registry, is R installed?' ]
]

{ #category : #'symbolic versions' }
ConfigurationOfRProjectConnector >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : #doits }
ConfigurationOfRProjectConnector >> getRLibs [
	" Private - Detect platform and get appropriate library files "

	Smalltalk os isWin32 
		ifTrue: [ self getRWinLibs ].
	Smalltalk os isUnix
		ifTrue: [ self getRUnixLibs ].
	(Smalltalk os isMacOS or: [ Smalltalk os isMacOSX ])
		ifTrue: [ self getRMacOSLibs ]
]

{ #category : #doits }
ConfigurationOfRProjectConnector >> getRMacOSLibs [

]

{ #category : #doits }
ConfigurationOfRProjectConnector >> getRUnixLibs [

]

{ #category : #doits }
ConfigurationOfRProjectConnector >> getRWinLibs [
	" Private - We need to query Windows Registry to find if R is installed, fetch the OSWindows package "
	
	self installOSWindow.
	self detectRWinInstallation.

	
]

{ #category : #doits }
ConfigurationOfRProjectConnector >> installOSWindow [
	" Private - Install support package "

	Gofer it
		smalltalkhubUser: 'Pharo' project: 'OSWindow';
		configuration;
		load.
	#ConfigurationOfOSWindows asClass load.
	
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

{ #category : #catalog }
ConfigurationOfRProjectConnector >> smalltalkHubDescription [
 ^'RProjectConnector is a library providing a binding between Pharo and R <http://www.r-project.org>, a statistical environment.This binding is done through NativeBoost primitive calls. 

Installation
================

In order to get it work, you should get the R libs. 

Under ubuntu
------------------------
It is better to have a 32 bits version of Ubuntu to get the libraries. I tried under a 64 bits versions and I not succeded to do it work.
To get them:

    dpkg --add-architecture i386
    apt-get update
    apt-get install r-base-core:i386

And copy the librairies ("libR.so") in the Pharo vm folder.

Under Windows 7
------------------------------
You should install R in 32bits (<http://cran.r-project.org/bin/windows/base/>) and copy the files grid.dll, R.dll, Rblas.dll, Rgraphapp.dll, Riconv.dll, Rlapack.dll and Rzlib.dll from R-3.1.1\bin\i386 to the pharo vm folder.


Under MacOs
-----------------------------
Not tried

Once you have your libraries, you can launch a Pharo image with the RProjectConnector installed:

    Gofer it 
        smalltalkhubUser: ''VincentBlondeau'' project: ''RProjectConnector'';
        configuration;
        loadStable

If you forgot to install the libraries or if they are not well installed, you should received a error startup but you are still able to launch your image.

Features and examples
=================
If you want to execute a R function, you should (for now) know what is the name of the function and the parameters that it takes.

For example, if you want to evaluate the method ''acf'' (Autocorrelation function) on a sample of data, you can do:

     data := (1 to: 1000) collect: #yourself.
     res := (#acf asRFunctionWith: {data asRVector}) eval

You should get a representation of a list under R (a RList) and you can interract with it by accessing the items either by index or by key (the list are sort of dictionnary-arrays):

     res at: ''coef''
     res at: 1


Moreover, you have the visualisation of the acf opened in a other window.

Like that, you can evaluate any method with ordered parameters.

To do
==========
- Add the error handling on function accessing:<https://stat.ethz.ch/pipermail/r-devel/2007-July/046261.html>
- Add the named function arguments (see failling tests: RListTest>>testCreateListWithOneElement, testCreateListWithOneNamedElement, testCreateListWithTwoElementsOneNamedOneNot and testInstallPackageShouldWork for the integration.
- Add missing types: matrix, data frames,...
- Plot importer
- Add invalidation of old handles at startup

Links
===============
- Some documentation on external R library on: <http://www.math.ncu.edu.tw/~chenwc/R_note/reference/package/R-exts.pdf> (p64)
- The RSources <http://cran.r-project.org/sources.html>. The header C file R-3.1.1\src\include\Rinternals.h shows all the functions that can be called through the primitives. For information, the compilation variable "USE_RINTERNALS" is not defined in the compiled libraries.
- Documentation on R environments: <http://adv-r.had.co.nz/Environments.html>
- Example in C: <https://gist.github.com/Sharpie/323498>
- The equivalent in Java but using the RServer: <http://www.rforge.net/Rserve/>

	"Returns an array of symbols"
	^ #(R NativeBoost Statistics Binding Connector) '
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
		spec package: 'RConnector' with: 'RConnector-VincentBLondeau.42'. ].

]
