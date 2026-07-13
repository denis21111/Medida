extends Area2D

var weight: int = 0
var is_revealed: bool = false
var is_selected: bool = false

var player_role: String = ""

@onready var label_node = $Label
@onready var sprite_node = $Sprite2D

const PACKAGE_COLORS = [
	Color(0.90, 0.30, 0.30),
	Color(0.95, 0.60, 0.15),
	Color(0.20, 0.75, 0.70),
	Color(0.25, 0.55, 0.95),
	Color(0.55, 0.35, 0.90),
	Color(0.90, 0.40, 0.75),
	Color(0.60, 0.60, 0.60),
	Color(0.55, 0.35, 0.20),
	Color(0.30, 0.80, 0.90),
]

func _ready():
	sprite_node.self_modulate = PACKAGE_COLORS[get_index() % PACKAGE_COLORS.size()]
	label_node.text = "?"

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		handle_tap()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		handle_tap()
		

func handle_tap():
	if player_role == "revealer":
		if not is_revealed:
			if GameManager.request_reveal():
				reveal_value()
				
	elif player_role == "changer":
		if GameManager.selected_package == null:
			select()
		elif GameManager.selected_package == self:
			deselect()
		else:
			var success = GameManager.swap_packages_by_node(GameManager.selected_package, self)
			if success:
				GameManager.selected_package.deselect()
				GameManager.selected_package = null
			else:
				GameManager.selected_package.deselect()
				self.deselect()
				GameManager.selected_package = null

func reveal_value():
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
