extends Control


func _ready() -> void:
	pass


func _on_retry_pressed() -> void:
	# Setzt das Elixier zurück auf den Startwert des gerade gespielten Levels
	GameManager.current_elixir = GameManager.start_elixir
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_level_selection_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector2.tscn")
