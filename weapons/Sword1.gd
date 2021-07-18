extends Weapon


func draw_process()->void:
	.draw_process()
	var x:float = offset.global_position.x - global_position.x
	sprite.global_rotation = deg2rad(5) * x
