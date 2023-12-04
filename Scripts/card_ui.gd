class_name CardUI
extends Control

#Signals
signal reparent_requested(which_card_ui : CardUI)

#Refrences
@onready var color : ColorRect = $Color
@onready var state : Label = $State
@onready var drop_point_detector = $DropPointDetector
@onready var card_state_machine : CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets : Array[Node] = []

func _ready():
	card_state_machine.init(self)

func _input(event):
	card_state_machine.on_input(event)

func _on_gui_input(event):
	card_state_machine.on_gui_input(event)

func _on_mouse_entered():
	card_state_machine.on_mouse_entered()

func _on_mouse_exited():
	card_state_machine.on_mouse_exited()

func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area):
	targets.erase(area)
