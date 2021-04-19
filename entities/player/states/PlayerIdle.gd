extends State

func on_ready()->void:
	pass

# warning-ignore:unused_argument
func process(delta)->void:
	entity.sprite_flip()
	state_check()

func physics(delta:float)->void:
	entity.set_dir()
	entity.physics(delta)

# warning-ignore:unused_argument
func input(event)->void:
	pass

# warning-ignore:unused_argument
func enter(data:Dictionary={})->void:
	entity.spritePlayer.play(entity.animList[entity.character][entity.IDLE])

func exit()->void:
	pass

func state_check()->void:
	if entity.dir.length() > 0.1:
		sm.transition("PlayerRun", {})
