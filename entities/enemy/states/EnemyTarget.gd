extends State

# warning-ignore:unused_argument
func process(delta)->void:
	entity.check_target()
	entity.targeting()

# warning-ignore:unused_argument
func enter(data:Dictionary={})->void:
	entity.dir = Vector2.RIGHT.rotated(randf()*PI*2) * 0.5
	entity.spritePlayer.play(entity.animList[entity.mob][1])




