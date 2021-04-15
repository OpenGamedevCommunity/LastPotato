extends Node
class_name StateMachine

export (NodePath) var firstStatePath
export (bool) var inputProcess = true	#Enemies don't need input

var currentState:State
var stateList:Dictionary

func _ready()->void:
	if !firstStatePath.is_empty():
		currentState = get_node(firstStatePath)
		set_process_unhandled_input(inputProcess)
	else:	#disable StateMachine
		set_process(false)
		set_physics_process(false)
		set_process_unhandled_input(false)

func _process(delta:float)->void:
	currentState.process(delta)

func _physics_process(delta:float)->void:
	currentState.physics_process(delta)

func _unhandled_input(event:InputEvent)->void:
	currentState.input(event)

func transition(stateName:String, data:Dictionary = {})->void:
	if !stateList.has(stateName):
		return
	
	currentState.exit()
	currentState = stateList[stateName]
	currentState.enter(data)
