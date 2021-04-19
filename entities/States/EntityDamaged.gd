extends State

export (float) var knockbackTime: = 1.0 /60 * 7

# warning-ignore:unused_argument
func physics(delta)->void:
	entity.velocity = entity.move_and_slide(entity.velocity)

# warning-ignore:unused_argument
func enter(data:Dictionary={})->void:
	entity.health -= data.damage
	if entity.health <= 0.0:
		sm.transition("EntityDeath", {})
		return
	
	entity.velocity = data.impulse			# give kickback
	stateTimeout()

func stateTimeout()->void:
	entity.stateTimer.start(knockbackTime)
	yield(entity.stateTimer, "timeout")			#state can be changed before timeout, need bypass variable
	sm.transition(sm.previousState, {})

func exit()->void:
	entity.velocity = Vector2.ZERO
