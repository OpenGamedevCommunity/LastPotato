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








# VISUALIZATION

var draw: = false
func _process(_delta:float)->void:
	update()

func _draw()->void:
	if !draw:
		return
	draw_circle(Vector2.ZERO, 2, Color.white)
	for t in owner.playerList:
		draw_line(t.global_position - global_position, Vector2.ZERO, Color.white)

func _input(event:InputEvent)->void:
	if event.is_action_pressed("ui_accept"):
		draw = !draw
		update()
