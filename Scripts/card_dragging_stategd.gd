extends CardState

#Data
const DRAG_MINIMUM_THRESHOLD : float = 0.05

var minimum_drag_time_elapsed : bool = false

func enter():
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.color.color = Color.DODGER_BLUE
	card_ui.state.text = "Dragging"
	
	minimum_drag_time_elapsed = false
	var threshol_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshol_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func on_input(event : InputEvent):
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("RMB")
	var confirm = event.is_action_released("LMB") or event.is_action_pressed("LMB")
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
