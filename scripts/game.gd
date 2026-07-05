extends Control
 
@onready var player_a_viewport = $PlayerA_ViewportContainer/SubViewport
@onready var player_b_viewport = $PlayerB_ViewportContainer/SubViewport
@onready var elixir_label = $ElixirLabel
 
func _ready():
	# zeigt was für rollen die spieler haben
	setup_roles(player_a_viewport, "revealer")
	setup_roles(player_b_viewport, "changer")
 
	# speilerA paketen
	var packages = get_packages(player_a_viewport)
	GameManager.initialize_level_packages(packages)
 
	sync_weights(player_a_viewport, player_b_viewport)
 
	# änderungen an der elixir
	GameManager.elixir_changed.connect(_on_elixir_changed)
	GameManager.level_won.connect(_on_level_won)
 
	elixir_label.text = "Elixir: " + str(GameManager.current_elixir)
 
func setup_roles(viewport: SubViewport, role: String):
	var packages = get_packages(viewport)
	for pkg in packages:
		pkg.player_role = role
 
func get_packages(viewport: SubViewport) -> Array:
	var production_line = viewport.get_node("ConveyorBelt/Background/ProductionLine")
	var packages = []
	for child in production_line.get_children():
		if child.has_method("reveal_value"):  # checks it's a package
			packages.append(child)
	return packages
 
func sync_weights(source_viewport: SubViewport, target_viewport: SubViewport):
	var source_packages = get_packages(source_viewport)
	var target_packages = get_packages(target_viewport)
 
	for i in range(min(source_packages.size(), target_packages.size())):
		target_packages[i].weight = source_packages[i].weight
 
func _on_elixir_changed(new_amount: int):
	elixir_label.text = "Elixir: " + str(new_amount)
 
func _on_level_won():
	# 
	elixir_label.text = "Gewonnen! Das Level ist korrekt sortiert."
