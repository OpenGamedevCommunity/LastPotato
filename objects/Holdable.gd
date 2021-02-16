extends Node2D
class_name Holdable

var user:KinematicBody2D


var dir: = Vector2.ZERO setget set_dir
func set_dir(value:Vector2)->void:
	if value.length() > 0.01:
		dir = value.normalized()

func use()->void:
	pass

func _unhandled_input(event):
	if event.is_action_pressed("action_p"+user.ctrl):
		use()
