extends Control


func _ready() -> void:
	pass


func _on_retry_pressed() -> void:
	GameManager.current_elixir = GameManager.start_elixir
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_level_selection_pressed() -> void:
	if GameManager.aktiver_algorithmus == "SELECTION_SORT":
		get_tree().change_scene_to_file("res://scenes/level_selector2.tscn")
	elif GameManager.aktiver_algorithmus == "BUBBLE_SORT":
		get_tree().change_scene_to_file("res://scenes/level_selector1.tscn")
