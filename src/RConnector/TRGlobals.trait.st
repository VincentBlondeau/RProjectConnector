"
A TRGlobals is a trait that defines global variables available in R.

"
Trait {
	#name : #TRGlobals,
	#category : #'RConnector-Core'
}

{ #category : #'trait - global variables' }
TRGlobals classSide >> rBaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rBaseEnv
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> rClassSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rClassSymbol
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> rEmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rEmptyEnv
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> rGlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rGlobalEnv
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> rNamesSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rNamesSymbol
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> rNilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rNilValue
]
