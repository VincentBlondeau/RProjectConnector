Trait {
	#name : #TRClassExtension,
	#category : #'RConnector-Core'
}

{ #category : #converting }
TRClassExtension classSide >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'private - instance creation' }
TRClassExtension classSide >> basicNew [
	^ super basicNew
		initializeHandle;
		yourself
]

{ #category : #'private - instance creation' }
TRClassExtension classSide >> primNew: size [
	^ self primNew: size type: self type
]

{ #category : #accessing }
TRClassExtension >> handle [
	"Code to compile : ^ handle value"
	self explicitRequirement.		

]

{ #category : #accessing }
TRClassExtension >> handle: aUint [
	"Code to compile instead : handle value: aUint"
	self explicitRequirement.		


]

{ #category : #initialization }
TRClassExtension >> initializeHandle [
	"Code to compile instead : handle := NBExternalHandle new"
	self explicitRequirement.		

	
]
