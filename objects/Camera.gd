extends Camera2D

export (Resource) var targetList:Resource
export (float) var lerpSpeed:float = 8.0

onready var pos: = global_position
#Camera needs to be calculated on the same thread as the player movement
#otherwise player sprite is unstable
func _physics_process(delta:float)->void:
	if targetList.list.size() < 1:
		return
	
	var middle: = Vector2.ZERO
	for inst in targetList.list:
		middle += inst.global_position
	middle = middle / targetList.list.size()
	
	pos = pos.linear_interpolate(middle, lerpSpeed * delta)
	global_position = pos.round()
