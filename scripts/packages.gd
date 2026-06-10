extends Area2D

var weight: int = 0
var is_revealed: bool = false

@onready var label_node = $Label

func _ready():
	# Beim Start ist das Paket immer verdeckt
	label_node.text = "?"

func _on_input_event(viewport, event, shape_idx):
	# Prüft, ob es ein Linksklick war
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_revealed:
			if GameManager.request_reveal():
				reveal_value()

func reveal_value():
	is_revealed = true
	label_node.text = str(weight)
	
	await get_tree().create_timer(5.0).timeout

	is_revealed = false
	label_node.text = "?"
