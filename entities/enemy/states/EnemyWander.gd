extends State

var bypassYield: = false

# warning-ignore:unused_argument
func process(delta)->void:
	entity.check_target()

# warning-ignore:unused_argument
func enter(data:Dictionary={})->void:
	entity.dir = Vector2.RIGHT.rotated(randf()*PI*2) * 0.5
	entity.spritePlayer.play(entity.animList[entity.mob][1])
	
	stateTimeout()

func exit()->void:
	bypassYield = true


func stateTimeout()->void:
	bypassYield = false
	entity.stateTimer.start(rand_range(2,5))
	yield(entity.stateTimer, "timeout")			#state can be changed before timeout, need bypass variable
	if !bypassYield:
		sm.transition("EnemyIdle", {})
