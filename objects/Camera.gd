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
	
	if !draw:
		update()







# VISUALIZATION

var draw: = false

func _draw()->void:
	if !draw:
		return
	draw_circle(Vector2.ZERO, 2, Color.white)
	for t in followList.list:
		draw_line(t.global_position - global_position, Vector2.ZERO, Color.white)

func _input(event:InputEvent)->void:
	if event.is_action_pressed("ui_accept"):
		draw = !draw
		update()
