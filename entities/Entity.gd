extends KinematicBody2D
class_name Entity



export(float) var maxHealth: = 100.0
var health: = maxHealth
var is_damaged: = false

export(float) var speed: = 1.0 * 60
var dir: = Vector2.ZERO
var velocity: = Vector2.ZERO


onready var body:Node2D = $Body
onready var sprite:Sprite = $Body/Sprite
onready var spritePlayer:AnimationPlayer = $Body/SpritePlayer

func _process(_delta:float)->void:
	process()

func _physics_process(_delta:float)->void:
	physics(_delta)

#inherited entities decide the implementation
func set_dir()->void:
	pass

func physics(_delta:float)->void:
	set_dir()
	velocity = dir * speed
	velocity = move_and_slide(velocity)

func process()->void:
	if abs(dir.x) > 0.01:
		body.scale.x = sign(dir.x)
	set_animation()

#inherited entities decide the implementation
func set_animation()->void:
	pass

func take_damage(damage: float)->void:
	health -= damage
	if health < 0.0:
		death()

func death()->void:
	queue_free()
