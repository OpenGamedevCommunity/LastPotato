extends Holdable
class_name Weapon


export(float) var attackSpeed: = 1.25
export(float) var damage: = 25.0
export(float) var knockback: = 200.0

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var attackBox:Area2D = $AttackBox


func _ready()->void:
# warning-ignore:return_value_discarded
	attackBox.connect("body_entered", self, "damage_body")
# warning-ignore:return_value_discarded
	animationPlayer.connect("animation_finished", self, "animation_finished")


func animation_finished(anim:String)->void:
	if anim == "Attack":
		if Input.is_action_pressed("action_p"+user.ctrl):
			attack()
		else:
			animationPlayer.play("Idle")


func use()->void:
		attack()


func attack()->void:
	animationPlayer.play("Attack", -1, attackSpeed)


func damage_body(body:PhysicsBody2D)->void:
	if body == user:
		return
	var dir:Vector2 = (body.global_position - global_position).normalized()
	
	body.take_damage(damage, dir *knockback)

