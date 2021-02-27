extends Node

signal input_changed

enum {KBM,JOY,TOUCH}
var input_methods: = ["Keyboard & Mouse", "Joypad", "Touch"]

var availible_actions: = ["left", "right", "up", "down", "action", "dash"]


var deadzone: = 0.5
var ctrl: = "1"
var active_input: = KBM

func _ready()->void:
# warning-ignore:return_value_discarded
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

func _unhandled_input(event:InputEvent)->void:
	if event is InputEventMouse:
		if active_input != KBM: swap_input(KBM)
		
	elif event is InputEventKey:
		if active_input != KBM: swap_input(KBM)
		
	elif event is InputEventJoypadMotion:
		if active_input != JOY and abs(event.axis_value)>deadzone: swap_input(JOY)
		var ev: = InputEventAction.new()
		match event.axis:
			JOY_ANALOG_LX:
				if event.axis_value < 0: ev.action = "left_p"+ctrl
				if event.axis_value > 0: ev.action = "right_p"+ctrl
			JOY_ANALOG_LY:
				if event.axis_value < 0: ev.action = "up_p"+ctrl
				if event.axis_value > 0: ev.action = "down_p"+ctrl
			_:
				pass
		if ev.action:
			ev.pressed = true if abs(event.axis_value) > deadzone else false
			ev.strength = abs(event.axis_value) if abs(event.axis_value) > deadzone else 0.0
			Input.parse_input_event(ev)
			
	elif event is InputEventJoypadButton:
		if active_input != JOY: swap_input(JOY)
		var ev: = InputEventAction.new()
		match event.button_index:
			0: # A
				ev.action = "action_p"+ctrl
			1: # B
				ev.action = "dash_p"+ctrl
			JOY_DPAD_UP:
				ev.action = "up_p"+ctrl
			JOY_DPAD_DOWN:
				ev.action = "down_p"+ctrl
			JOY_DPAD_LEFT:
				ev.action = "left_p1"+ctrl
			JOY_DPAD_RIGHT:
				ev.action = "right_p"+ctrl
			JOY_SELECT:
				if !event.pressed:
					release_actions(ctrl)
					ctrl = "2" if ctrl == "1" else "1"
					print("Joypad controlling to Player "+ctrl)
			_:
				pass
		ev.pressed = event.pressed
		if ev.action: Input.parse_input_event(ev)


func swap_input(input:int)->void:
	active_input = input
	emit_signal("input_changed", input)
	print("Input changed to: " + input_methods[input])


func release_actions(player:String)->void:
	for action in availible_actions:
		if Input.is_action_pressed(action+"_p"+player):
			Input.action_release(action+"_p"+player)


func _on_joy_connection_changed(device_id:int, connected:bool)->void:
	if connected:
		swap_input(JOY)
		print(Input.get_joy_name(device_id))
	else:
		swap_input(KBM)
		print("Keyboard & Mouse")
