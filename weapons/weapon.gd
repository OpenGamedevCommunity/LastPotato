extends Holdable
class_name Weapon

#enum and const are accesible without making instance
#we can use it as data set for weapons
enum WeaponList {
	SWORD1
}
const WeaponScenes: = [
	"res://weapons/Sword1.tscn",
]

export(float) var attackSpeed: = 1.25

onready var animationPlayer:AnimationPlayer = $AnimationPlayer
onready var attackBox:Area2D = $AttackBox

func _ready()->void:
# warning-ignore:return_value_discarded
	attackBox.connect("body_entered", self, "body_entered")
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

export(bool) var attacking: = false
func attack()->void:
	animationPlayer.play("Attack", -1, attackSpeed)


func body_entered(body:PhysicsBody2D)->void:
	if body == user:
		return

	if attacking:
		print("attacking: ", body)

