extends Camera2D


onready var pos: = global_position
#Camera needs to be calculated on the same thread as the player movement
#otherwise player sprite is unstable
func _physics_process(delta:float)->void:
	var middle: = Vector2.ZERO
	for t in owner.playerList:
		middle += t.global_position
	middle = middle / owner.playerList.size()
	
	if owner.playerList.size() > 0:
		pos = pos.linear_interpolate(middle, 8.0*delta)
		global_position = pos.round()
