extends State

var bypassYield: = false

# warning-ignore:unused_argument
func process(delta)->void:
	entity.check_target()

# warning-ignore:unused_argument
func enter(data:Dictionary={})->void:
	entity.spritePlayer.play(entity.animList[entity.mob][0])
	entity.dir = Vector2.ZERO
	stateTimeout()

func exit()->void:
	bypassYield = true

func stateTimeout()->void:
	bypassYield = false
	entity.stateTimer.start(rand_range(1,2))
	yield(entity.stateTimer, "timeout")			#state can be changed before timeout, need bypass variable
	if !bypassYield:
		sm.transition("EnemyWander", {})
