extends Node2D
class_name Holdable

var user:KinematicBody2D


func use()->void:
	pass

func _unhandled_input(event):
	if event.is_action_pressed("action_p"+user.ctrl):
		use()
