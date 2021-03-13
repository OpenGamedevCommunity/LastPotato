extends Entity

enum MobList{
	MOB1,
	MOB2,
	MOB3,
	MOB4,
}
export(MobList) var mob: = 0

var animList: = [
	["mob1_idle",	"mob1_run"],
	["mob2_idle",	"mob2_run"],
	["mob3_idle",	"mob3_run"],
	["mob4_idle",	"mob4_run"],
]

enum {
	IDLE,
	WANDER,
	TARGET,
	HIT,
	HURT
}

var state: = IDLE
var target:KinematicBody2D
export(float) var agroRange: = 64.0
export(float) var attackRange: = 5.0

func on_ready()->void:
	set_idle()

#inherited entities decide the implementation
func set_dir()->void:
	if state == TARGET && target:
		var direction:Vector2 = (target.global_position - global_position)
		if direction.length() <= agroRange:
			dir = direction.normalized()
		else:
			target = null
			set_wander()


func process()->void:
	check_target()
	.process()	#call inherited function from Entity


func set_animation()->void:
	if is_damaged:
		spritePlayer.play(animList[mob][0])	#idle while prototyping
		return
		
	match state:
		IDLE:
			spritePlayer.play(animList[mob][0])
		WANDER:
			spritePlayer.play(animList[mob][1])
		TARGET:
			spritePlayer.play(animList[mob][1])

func set_idle()->void:
	state = IDLE
	stateTimer.start(rand_range(1,2))
	dir = Vector2.ZERO

func set_wander()->void:
	state = WANDER
	stateTimer.start(rand_range(2,5))
	dir = Vector2.RIGHT.rotated(randf()*PI*2) * 0.5

func check_target()->void:
	var dist: = agroRange
	for t in owner.playerList:
		var d:float = (t.global_position - global_position).length()
		if d <= dist:
			dist = d
			target = t
			state = TARGET

func stateTimeout()->void:
	if state == IDLE:
		set_wander()
	elif state == WANDER:
		set_idle()



