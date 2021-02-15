extends Camera2D


func _ready()->void:
# warning-ignore:return_value_discarded
	owner.connect("add_player", self, "add_player")
# warning-ignore:return_value_discarded
	owner.connect("remove_player", self, "remove_player")


var targets:Array
func add_player(player:KinematicBody2D)->void:
	targets.append(player)
	print(player)

func remove_player(player:KinematicBody2D)->void:
	targets.erase(player)

onready var pos: = global_position
#Camera needs to be calculated on the same thread as the player movement
#otherwise player sprite is unstable
func _physics_process(delta:float)->void:
	var middle: = Vector2.ZERO
	for t in targets:
		middle += t.global_position
	middle = middle / targets.size()
	
	if targets.size() > 0:
		pos = pos.linear_interpolate(middle, 8.0*delta)
		global_position = pos.round()
