extends Node2D
class_name Holdable


var user:KinematicBody2D
onready var offset: = $Offset
onready var sprite: = $Offset/Sprite
onready var parent: = get_parent()
var myIndex: = 1


func _ready()->void:
	on_ready()


func _process(_delta:float)->void:
	draw_process()


func on_ready()->void:
	pass


func use()->void:
	pass

func draw_process()->void:
	if user.dir.length() > 0.5:
		rotation = user.dir.angle()
	sprite.global_rotation = 0.0
	show_behind_parent = (offset.global_position.y - global_position.y) < 0.0

