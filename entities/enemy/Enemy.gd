extends Entity

enum MobList{
	MOB1,
	MOB2,
	MOB3,
	MOB4,
}
export(MobList) var mob: = 0
export(Resource) var playerList

var animList: = [
	["mob1_idle",	"mob1_run"],
	["mob2_idle",	"mob2_run"],
	["mob3_idle",	"mob3_run"],
	["mob4_idle",	"mob4_run"],
]

var target:KinematicBody2D
export(float) var agroRange: = 64.0
export(float) var attackRange: = 5.0

func on_ready()->void:
	sm.start("EnemyIdle", {})

func physics(delta:float)->void:
	velocity = velocity.move_toward(dir * speed, acceleration *delta)
	velocity = move_and_slide(velocity)


# used by State
func check_target()->void:
	var dist: = agroRange
	target = null
	for t in playerList.list:
		var d:float = (t.global_position - global_position).length()
		if d <= dist:
			dist = d
			target = t

# used by State
func targeting()->void:
	if !is_damaged && target:
		var direction:Vector2 = (target.global_position - global_position)
		if direction.length() <= agroRange:
			dir = direction.normalized()
		else:
			target = null
