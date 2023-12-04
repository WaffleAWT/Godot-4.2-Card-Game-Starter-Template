extends CardState

#Data
var played : bool

func enter():
	card_ui.color.color = Color.BLUE_VIOLET
	card_ui.state.text = "Released"
	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		print("Play card for target(s) ", card_ui.targets)

func on_input(_event : InputEvent):
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)
