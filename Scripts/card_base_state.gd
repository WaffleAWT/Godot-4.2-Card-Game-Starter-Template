extends CardState

func enter():
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color.DARK_GREEN
	card_ui.state.text = "Base"
	card_ui.pivot_offset = Vector2.ZERO

func on_gui_input(event : InputEvent):
	if event.is_action_pressed("LMB"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
