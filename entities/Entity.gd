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

func _ready()->void:
# warning-ignore:return_value_discarded
	stateTimer.connect("timeout", self, "stateTimeout")
	# overridable function to reduce triggering _ready on all inheritted levels
	on_ready()

func _process(_delta:float)->void:
	process()

func _physics_process(_delta:float)->void:
	physics(_delta)

func on_ready()->void:
	pass

#inherited entities decide the implementation
func set_dir()->void:
	pass

func physics(delta:float)->void:
	if !is_damaged:
		set_dir()
	velocity = velocity.move_toward(dir * speed, acceleration *delta)
	velocity = move_and_slide(velocity)

func process()->void:
	if abs(dir.x) > 0.01:
		body.scale.x = sign(dir.x)
	set_animation()

#inherited entities decide the implementation
func set_animation()->void:
	pass

func take_damage(damage: float, impulse: = Vector2.ZERO)->void:
	if is_damaged:
		return
	is_damaged = true
	health -= damage
	if health <= 0.0:
		death()
	else:
		acceleration = acc *4		# alter value balancing with impulse
		velocity = impulse			# give kickback
		dir = Vector2.ZERO			# reset dir
		stateTimer.start(recoveryTime)
		yield(stateTimer, "timeout")
		is_damaged = false
		acceleration = acc

func death()->void:
	queue_free()


func stateTimeout()->void:
	pass
