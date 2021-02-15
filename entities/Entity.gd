extends KinematicBody2D
class_name Entity



export(float) var speed: = 1.0 * 60
var dir: = Vector2.ZERO
var velocity: = Vector2.ZERO


onready var body:Node2D = $Body
onready var sprite:Sprite = $Body/Sprite
onready var spritePlayer:AnimationPlayer = $Body/SpritePlayer

#inherited entities decide the implementation
func set_dir()->void:
	pass

func _physics_process(_delta:float)->void:
	set_dir()
	velocity = dir * speed
	velocity = move_and_slide(velocity)

func _process(_delta:float)->void:
	if abs(dir.x) > 0.01:
		sprite.flip_h = dir.x < 0.0
	set_animation()

#inherited entities decide the implementation
func set_animation()->void:
	pass
