extends Entity

export(String) var ctrl = '1'

enum CharList{
	ROGUE_FEMALE,
	ROGUE_MALE,
	KNIGHTT_FEMALE,
	KNIGHT_MALE,
	MAGE_FEMALE,
	MAGE_MALE
}
export(CharList) var character: = 1

enum {IDLE,RUN}		# used for animation Array index
var animList: = [
	["rogue_f_idle",	"rogue_f_run"],
	["rogue_m_idle",	"rogue_m_run"],
	["knight_f_idle",	"knight_f_run"],
	["knight_m_idle",	"knight_m_run"],
	["mage_f_idle",		"mage_f_run"],
	["mage_m_idle",		"mage_m_run"],
]


var holdable:Holdable
func on_ready()->void:
	owner.playerList.append(self)
	holdable = $Body/Sword1
	holdable.user = self
	sm.start("PlayerIdle", {})

func physics(delta:float)->void:
	velocity = velocity.move_toward(dir * speed, acceleration *delta)
	velocity = move_and_slide(velocity)



func set_dir()->void:
	dir.x = Input.get_action_strength("right_p"+ctrl) - Input.get_action_strength("left_p"+ctrl)
	dir.y = Input.get_action_strength("down_p"+ctrl) - Input.get_action_strength("up_p"+ctrl)
	#normalize if exceeds length of 1.0
	if dir.length() > 1.0:
		dir = dir.normalized()


func _exit_tree()->void:
	owner.playerList.erase(self)
