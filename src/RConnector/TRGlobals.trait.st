"
A TRGlobals is a trait that defines global variables available in R.

"
Trait {
	#name : #TRGlobals,
	#category : #'RConnector-Core'
}

{ #category : #'trait - global variables' }
TRGlobals classSide >> R_BaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_BaseEnv
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> R_EmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_EmptyEnv
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> R_GlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_GlobalEnv
]

{ #category : #'trait - global variables' }
TRGlobals classSide >> R_NilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NilValue
]
