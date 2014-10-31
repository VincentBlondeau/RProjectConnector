Class {
	#name : #RConnect,
	#superclass : #Object,
	#classVars : [
		'SocketInstance'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RConnect class >> closeConnection [ 
	SocketInstance close.
	SocketInstance destroy
]

{ #category : #'as yet unclassified' }
RConnect class >> connect [
	"Std Timeout 45 secs"

	| identification |
	SocketInstance ifNotNil: [ self closeConnection ].
	SocketInstance := SocketStream openConnectionToHostNamed: 'localhost' port: 6311.
	SocketInstance noTimeout.
	[ 
	identification := SocketInstance next: 32.
	self assert: (identification copyFrom: 1 to: 4) = 'Rsrv'.
	self assert: (identification copyFrom: 5 to: 8) = '0103' ]
		on: ConnectionTimedOut
		do: [ ServerNotAvailable signal ].
	^ self
]

{ #category : #'as yet unclassified' }
RConnect class >> eval: param [
	| res |
	self isConnected
		ifFalse: [ self connect ].
	res := QAP1 new command: QAP1Command eval andParam: param.
	res halt.
]

{ #category : #'as yet unclassified' }
RConnect class >> isConnected [
	^ SocketInstance isNotNil and: [ SocketInstance isConnected ]
]

{ #category : #'as yet unclassified' }
RConnect class >> mkStringWithId: cmdId andCommand: cmd [
	| stream  streamResult n|
	streamResult := TextStream on: cmd.
		streamResult nextPut: (Character value: 0).
	(4 - streamResult size % 4) timesRepeat: [ streamResult nextPut: ( Character value: 1)].
	n := streamResult size.
	stream := TextStream on: cmdId bitString.
	stream nextPutAll: (n + 4)  bitString.
	stream nextPutAll: 0 bitString.
	stream nextPutAll: 0 bitString.
	stream nextPut: (Character value: 4).
	stream nextPutAll: (n asByteArrayOfSize: 24).
	stream nextPutAll: streamResult contents.
^ stream contents
	
]

{ #category : #'as yet unclassified' }
RConnect >> R_GlobalEnv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbGetSymbolAddress: #R_GlobalEnv
        module: #R
]

{ #category : #'as yet unclassified' }
RConnect >> Rf_initEmbeddedR [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #( int Rf_initEmbeddedR(int argc, char *argv[]) )
        module: #R
]

{ #category : #'as yet unclassified' }
RConnect >> Rf_initEmbeddedRArgc: argc argv: argv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #( int Rf_initEmbeddedR(int argc, char ** argv) )
        module: #R
]

{ #category : #'as yet unclassified' }
RConnect >> Rf_install: aChar [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aChar));
        module: #R
]

{ #category : #'as yet unclassified' }
RConnect >> isExistsRf_initEmbeddedR [
	^ (self nbGetSymbolAddress: 'Rf_initEmbeddedR' module: #R) isNotNil
]

{ #category : #'as yet unclassified' }
RConnect >> test [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #( double unif_rand(void) )
        module: #R
]

{ #category : #'as yet unclassified' }
RConnect >> unif_rand [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #( double unif_rand(void) )
        module: #R
]
