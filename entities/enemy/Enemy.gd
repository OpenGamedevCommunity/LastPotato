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
	HIT
}

var state: = IDLE
var target:KinematicBody2D
export(float) var agroRange: = 64.0
export(float) var attackRange: = 5.0
onready var timer:Timer = $Timer

func _ready()->void:
# warning-ignore:return_value_discarded
	timer.connect("timeout", self, "timeout")
	set_idle()

#inherited entities decide the implementation
func set_dir()->void:
	if state == TARGET && target:
		var direction:Vector2 = (target.global_position - global_position)
		if direction.length() <= agroRange:
			dir = direction.normalized()
		else:
			set_wander()

func physics(_delta:float)->void:
	set_dir()
	velocity = dir * speed
	velocity = move_and_slide(velocity)

func process()->void:
	if abs(dir.x) > 0.01:
		body.scale.x = sign(dir.x)
	check_target()
	set_animation()

#inherited entities decide the implementation
func set_animation()->void:
	match state:
		IDLE:
			spritePlayer.play(animList[mob][0])
		WANDER:
			spritePlayer.play(animList[mob][1])
		TARGET:
			spritePlayer.play(animList[mob][1])

func set_idle()->void:
	state = IDLE
	timer.start(rand_range(1,2))
	dir = Vector2.ZERO

func set_wander()->void:
	state = WANDER
	timer.start(rand_range(2,5))
	dir = Vector2.RIGHT.rotated(randf()*PI*2) * 0.5

func check_target()->void:
# warning-ignore:unused_variable
	var dist: = agroRange
	for t in owner.playerList:
		var d:float = (t.global_position - global_position).length()
		if d <= dist:
			dist = d
			target = t
			state = TARGET

func timeout()->void:
	if state == IDLE:
		set_wander()
	elif state == WANDER:
		set_idle()



