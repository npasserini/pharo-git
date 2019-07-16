"
I am a visitor of IceDiff (and IceDefinition) collect the initial ser of dependencies in an instance of IceCherrypicker.

"
Class {
	#name : #IceCherrypickerInitialDependenciesCollector,
	#superclass : #IceTreeVisitor,
	#instVars : [
		'cherrypicker'
	],
	#category : #'Iceberg-Cherrypicking'
}

{ #category : #accessing }
IceCherrypickerInitialDependenciesCollector >> cherrypicker [
	^ cherrypicker
]

{ #category : #accessing }
IceCherrypickerInitialDependenciesCollector >> cherrypicker: anIceCherrypicker [

	cherrypicker := anIceCherrypicker
]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitAddition: anIceAddition [ 
	
	anIceAddition definition accept: self.
]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitClassDefinition: anIceClassDefinition [

	anIceClassDefinition isMeta
		ifTrue: [ cherrypicker addMetaclassDependencyToClassNamed: anIceClassDefinition basicName ]
		ifFalse: [ cherrypicker addClassDependencyOf: anIceClassDefinition asMCDefinition ]
]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitMethodNode: anIceMethodDefinition [ 
	
	cherrypicker addMethodDependencyOf: anIceMethodDefinition asMCDefinition.	

]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitModification: anIceModification [ 
	
	anIceModification definition accept: self.

]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitNoModification: anIceNoModification [ 
	
	"Nothing with me. Just visit children"
	self visitChildrenOf: currentNode.
]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitPackage: anIcePackageDefinition [ 
	
	cherrypicker addPackageDependencyOfPackageNamed: anIcePackageDefinition name
]

{ #category : #visiting }
IceCherrypickerInitialDependenciesCollector >> visitTraitDefinition: anIceTraitDefinition [ 

	cherrypicker addTraitDependencyOf: anIceTraitDefinition asMCDefinition.	
]