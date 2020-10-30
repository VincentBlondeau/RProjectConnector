"
RProjectConnector is a library providing a binding between Pharo and R <http://www.r-project.org>, a statistical environment.This binding is done through NativeBoost primitive calls. 

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

And copy the librairies (""libR.so"") in the Pharo vm folder.

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
- The RSources <http://cran.r-project.org/sources.html>. The header C file R-3.1.1\src\include\Rinternals.h shows all the functions that can be called through the primitives. For information, the compilation variable ""USE_RINTERNALS"" is not defined in the compiled libraries.
- Documentation on R environments: <http://adv-r.had.co.nz/Environments.html>
- Example in C: <https://gist.github.com/Sharpie/323498>
- The equivalent in Java but using the RServer: <http://www.rforge.net/Rserve/>

	""Returns an array of symbols""
	^ #(R NativeBoost Statistics Binding Connector) 
"
Class {
	#name : #BaselineOfRProjectConnector,
	#superclass : #BaselineOf,
	#category : #BaselineOfRProjectConnector
}

{ #category : #baselines }
BaselineOfRProjectConnector >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			"spec preLoadDoIt: #'preload'."
			
			spec
				repository: 'http://smalltalkhub.com/mc/VincentBlondeau/RProjectConnector/main/'.
			spec
				package: #RConnector;
				package: #'RConnector-Tests'
					with: [ spec requires: #(#RConnector) ].
			spec group: 'Core' with: #(#RConnector #'RConnector-Tests') ]
]

{ #category : #catalog }
BaselineOfRProjectConnector >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ '- 1.0 - 05 dec 2014 - first release: execution of simple functions and types
[[[
	ConfigurationOfRProjectConnector project version: ''1.0'' ) load					
]]]
	- 1.2 - 2015 - Improvement of some features
[[[
	ConfigurationOfRProjectConnector project version: ''1.2'' ) load					
]]]
	- 2.0 - 31 aug 2016 - migration to UFFI
[[[
	ConfigurationOfRProjectConnector project version: ''2.1'' ) load					
]]]'
]

{ #category : #catalog }
BaselineOfRProjectConnector >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'RProjectConnector is the first R project connector for Pharo with UFFI. You can get in contact with our great RProjectConnector programmer at vincent.blondeau@polytech-lille.net'
]

{ #category : #catalog }
BaselineOfRProjectConnector >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'RProjectConnector is the first R project connector for Pharo with UFFI. It is using the standard R libs to execute your functions and get the result under Pharo objects. You can even show the graphs that you have in R.'
]

{ #category : #catalog }
BaselineOfRProjectConnector >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'RConnector is composed of one key class named ==RObject==. There is also ==RFunction== and ==RVector==
- ==RObject== is the responsible for representing any R external object. 
- ==RFunction== is able to create and execute R function with non named parameters
- ==RVector== and it subclasses are some types mostly obtained after the evaluation of a RFunction. As they extend OrderedCollection, you can interract easily with them.'
]

{ #category : #catalog }
BaselineOfRProjectConnector >> catalogKeywords [
	"Returns an array of symbols"
	^ #(R NativeBoost UFFI Statistics Binding Connector) 
]

{ #category : #doits }
BaselineOfRProjectConnector >> detectRWinInstallation [
	| rPath winRegistry winRegistryKey |
	winRegistry := Smalltalk at: #WinRegistry.
	winRegistryKey := Smalltalk at: #WinRegistryKey.
	(rPath := winRegistry queryValue: 'InstallPath' fromKey: (winRegistryKey localMachine queryOpenSubkey: 'Software\\R-core\\R')) notNil
		ifTrue: [ self copyRWinLibs: rPath allButLast  ]
		ifFalse: [ Transcript show: 'R (32-bit) was not detected in Windows Registry, is R installed?' ]
]

{ #category : #doits }
BaselineOfRProjectConnector >> getRLibs [
	" Private - Detect platform and get appropriate library files "

	Smalltalk os isWin32 
		ifTrue: [ self getRWinLibs ].
	Smalltalk os isUnix
		ifTrue: [ self getRUnixLibs ].
	(Smalltalk os isMacOS or: [ Smalltalk os isMacOSX ])
		ifTrue: [ self getRMacOSLibs ]
]

{ #category : #doits }
BaselineOfRProjectConnector >> getRMacOSLibs [

]

{ #category : #doits }
BaselineOfRProjectConnector >> getRUnixLibs [
	" Get R 32-bit for RH platforms : http://www.kodkast.com/linux-package-installation-steps?pkg=R.i386
	"

	#('/usr/lib/R/bin'
	'/usr/local/lib/R/bin/'
	'/usr/local/lib/R/lib/'
	'/usr/lib64/R/lib/') 
		detect: [ : path | (path asFileReference / 'libR.so') exists ]
		ifFound: [ : pathName | self copyRLinuxLibs: pathName ]
		ifNone: [ Transcript show: 'R was not detected in lib path, is R installed?' ]
]

{ #category : #doits }
BaselineOfRProjectConnector >> getRWinLibs [
	" Private - We need to query Windows Registry to find if R is installed, fetch the OSWindows package "
	
	self installOSWindow.
	self detectRWinInstallation.

	
]

{ #category : #doits }
BaselineOfRProjectConnector >> installOSWindow [
	" Private - Install support package "

	Gofer it
		smalltalkhubUser: 'OS' project: 'OS-Windows';
		configurationOf: 'OSWindows';
		load.
	#ConfigurationOfOSWindows asClass load.
	
]

{ #category : #baselines }
BaselineOfRProjectConnector >> preLoad [

	self getRLibs.
]
