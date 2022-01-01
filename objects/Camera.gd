extends Camera2D

export (Resource) var followList
export (float) var lerpSpeed: = 8.0

onready var pos: = global_position
#Camera needs to be calculated on the same thread as the player movement
#otherwise player sprite is unstable















func _process(delta:float)->void:
	if followList.list.empty():
		return
	
	var middle: = Vector2.ZERO
	for t in followList.list:
		middle += t.global_position
	middle = middle / followList.list.size()
	
	pos = pos.linear_interpolate(middle, lerpSpeed*delta)
	global_position = pos.round()















