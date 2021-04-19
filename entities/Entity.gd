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

func on_ready()->void:
	pass

# warning-ignore:unused_argument
func sprite_flip()->void:
	if abs(dir.x) > 0.01:
		body.scale.x = sign(dir.x)

func take_damage(damage: float, impulse: = Vector2.ZERO)->void:
	sm.transition("EntityDamaged", {damage = damage, impulse = impulse})

func death()->void:
	queue_free()

