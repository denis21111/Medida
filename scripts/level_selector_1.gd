extends Control

func _on_escape_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")

func _on_button_1_pressed() -> void:
	GameManager.aktiver_algorithmus = "BUBBLE_SORT"
	GameManager.pakete_anzahl = 9
	GameManager.start_elixir = 30
	GameManager.current_elixir = 30
	GameManager.feste_start_reihenfolge = [3, 2, 1, 6, 5, 4, 9, 8, 7]
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_2_pressed() -> void:
	GameManager.aktiver_algorithmus = "BUBBLE_SORT"
	GameManager.pakete_anzahl = 9
	GameManager.start_elixir = 40
	GameManager.current_elixir = 40
	GameManager.feste_start_reihenfolge = [5, 4, 3, 2, 1, 9, 8, 7, 6]
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_3_pressed() -> void:
	GameManager.aktiver_algorithmus = "BUBBLE_SORT"
	GameManager.pakete_anzahl = 9
	GameManager.start_elixir = 78 
	GameManager.current_elixir = 78
	GameManager.feste_start_reihenfolge = [9, 8, 7, 6, 5, 4, 3, 2, 1]
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_tutorial_1_pressed() -> void:
	get_tree().change_scene_to_file("res://TutorialBubbleSort.tscn")
