extends Area2D

var weight: int = 0
var is_revealed: bool = false
var is_selected: bool = false

var player_role: String = ""

@onready var label_node = $Label
@onready var sprite_node = $Sprite2D

func _ready():
	# Beim Start ist das Paket immer verdeckt
	label_node.text = "?"

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		print('input detected')
		handle_tap()
	# Prüft, ob es ein Linksklick war
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		handle_tap()
		

func handle_tap():
	print("handle_tap called, role: ", player_role)
	if player_role == "revealer":
		# die nummer von package zeigen
		if not is_revealed:
			if GameManager.request_reveal():
				reveal_value()
				
	elif player_role == "changer":
		print("changer tapped node: ", self.name, " | currently selected: ", GameManager.selected_package)
		# die paket wählen
		if GameManager.selected_package == null:
			# erste click
			select()
		elif GameManager.selected_package == self:
			deselect()
		else:
			# zweite paket wählen, swap
			var success = GameManager.swap_packages_by_node(GameManager.selected_package, self)
			if success:
				GameManager.selected_package.deselect()
				GameManager.selected_package = null

func reveal_value():
	print("revealing value: ", weight)
	is_revealed = true
	label_node.text = str(weight)
	modulate = Color(1, 1, 0.5)
	
	await get_tree().create_timer(5.0).timeout

	is_revealed = false
	label_node.text = "?"
	modulate = Color(1, 1, 1)
	
func select():
	is_selected = true
	GameManager.selected_package = self
	modulate = Color(0.5, 1, 0.5)  
 
func deselect():
	is_selected = false
	modulate = Color(1, 1, 1)
