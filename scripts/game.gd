extends Control
 
@onready var player_a_viewport = $PlayerA_ViewportContainer/SubViewport
@onready var player_b_viewport = $PlayerB_ViewportContainer/SubViewport
@onready var elixir_label = $ElixirContainerA/ElixirLabel
@onready var elixir_label_b = $ElixirContainerB/ElixirLabel
 
func _ready():
	await get_tree().process_frame
	
	GameManager.elixir_changed.connect(_on_elixir_changed)
	GameManager.level_won.connect(_on_level_won)
	GameManager.algorithm_error.connect(_on_algorithm_error)
	
	setup_roles(player_a_viewport, "revealer")
	setup_roles(player_b_viewport, "changer")
	
	var changer_packages = get_packages(player_b_viewport)
	GameManager.initialize_level_packages(changer_packages)
	GameManager.revealer_packages = get_packages(player_a_viewport)

	sync_weights(player_b_viewport, player_a_viewport)
 
	_update_elixir_display(GameManager.current_elixir)
 
func setup_roles(viewport: SubViewport, role: String):
	var packages = get_packages(viewport)
	for pkg in packages:
		pkg.player_role = role
 
func get_packages(viewport: SubViewport) -> Array:
	var production_line = viewport.get_node("ConveyorBelt/Background/ProductionLine")
	var packages = []
	for child in production_line.get_children():
		if child.has_method("reveal_value"):
			packages.append(child)
	return packages
 
func sync_weights(source_viewport: SubViewport, target_viewport: SubViewport):
	var source_packages = get_packages(source_viewport)
	var target_packages = get_packages(target_viewport)
 
	for i in range(min(source_packages.size(), target_packages.size())):
		target_packages[i].weight = source_packages[i].weight
 
func _on_elixir_changed(new_amount: int):
	_update_elixir_display(new_amount)
	
func _update_elixir_display(amount: int):
	elixir_label.text = str(amount)
	elixir_label_b.text = str(amount)
	if amount <= 3:
		elixir_label.modulate = Color(1, 0, 0)
		elixir_label_b.modulate = Color(1, 0, 0)
	else:
		elixir_label.modulate = Color(1, 1, 1)
		elixir_label_b.modulate = Color(1, 1, 1)
	
func _on_level_won():
	elixir_label.modulate = Color(1, 1, 1)
	elixir_label_b.modulate = Color(1, 1, 1)
	elixir_label.text = "Gewonnen!"
	elixir_label_b.text = "Gewonnen!"
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")

func _on_algorithm_error():
	elixir_label.text = "Falscher Schritt!"
	elixir_label_b.text = "Falscher Schritt!"
	elixir_label.modulate = Color(1, 0, 0)
	elixir_label_b.modulate = Color(1, 0, 0)
	
	await get_tree().create_timer(2.0).timeout
	_update_elixir_display(GameManager.current_elixir)

func _on_button_pressed() -> void:
	$ExitConfirmDialog.popup_centered()

func _on_confirmation_dialog_confirmed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
