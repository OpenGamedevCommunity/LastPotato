extends KinematicBody2D
class_name Entity



export(float) var maxHealth: = 100.0
var health: = maxHealth
var is_damaged: = false

export(float) var speed: = 1.0 * 60
export(float) var acc: = 250.0	#default value
export(float) var recoveryTime: = 0.5

var acceleration: = acc		#variable for manipulation. Low value acts as walking on ice
var dir: = Vector2.ZERO
var velocity: = Vector2.ZERO


onready var body:Node2D = $Body
onready var sprite:Sprite = $Body/Sprite
onready var spritePlayer:AnimationPlayer = $Body/SpritePlayer
onready var stateTimer:Timer = $StateTimer
onready var sm:Node = $StateMachine

func _ready()->void:
	# overridable function to reduce triggering _ready on all inheritted levels
	on_ready()

func _process(delta:float)->void:
	process(delta)

func _physics_process(_delta:float)->void:
	physics(_delta)

func on_ready()->void:
	pass

# warning-ignore:unused_argument
func physics(delta:float)->void:
	pass

# warning-ignore:unused_argument
func process(delta:float)->void:
	pass


func take_damage(damage: float, impulse: = Vector2.ZERO)->void:
	if is_damaged:
		return
	is_damaged = true
	health -= damage
	if health <= 0.0:
		# TO-DO: Death state
		death()
	else:
		#TO-DO: Damaged state
		acceleration = acc *4		# alter value balancing with impulse
		velocity = impulse			# give kickback
		dir = Vector2.ZERO			# reset dir
		stateTimer.start(recoveryTime)
		yield(stateTimer, "timeout")
		is_damaged = false
		acceleration = acc

func death()->void:
	queue_free()

