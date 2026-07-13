extends Control


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_escape_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector.tscn")


# LEVEL 1 (4 Tausche nötig, 30 Elixier -> Sehr großzügig zum Lernen)
func _on_button_pressed() -> void:
	GameManager.aktiver_algorithmus = "SELECTION_SORT"
	GameManager.pakete_anzahl = 9
	GameManager.start_elixir = 30 
	GameManager.current_elixir = 30
	GameManager.feste_start_reihenfolge = [7, 4, 9, 2, 1, 8, 5, 3, 6]
	get_tree().change_scene_to_file("res://scenes/game.tscn")


# LEVEL 2 (4 Tausche nötig, 26 Elixier -> Mittlerer Puffer)
func _on_button_2_pressed() -> void:
	GameManager.aktiver_algorithmus = "SELECTION_SORT"
	GameManager.pakete_anzahl = 9
	GameManager.start_elixir = 26
	GameManager.current_elixir = 26
	GameManager.feste_start_reihenfolge = [5, 3, 1, 9, 8, 2, 4, 7, 6]
	get_tree().change_scene_to_file("res://scenes/game.tscn")


# LEVEL 3 (Schwer - Mathematisch gelöst: 19 nötig, 22 gegeben -> Extrem knapp und spannend!)
func _on_button_3_pressed() -> void:
	GameManager.aktiver_algorithmus = "SELECTION_SORT"
	GameManager.pakete_anzahl = 9
	GameManager.start_elixir = 22 
	GameManager.current_elixir = 22
	GameManager.feste_start_reihenfolge = [9, 8, 7, 6, 1, 2, 3, 4, 5]
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_tutorial_1_pressed() -> void:
	get_tree().change_scene_to_file("res://TutorialSelectionSort.tscn")
