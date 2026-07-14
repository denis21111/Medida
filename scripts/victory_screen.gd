extends Control

@onready var elixir_label = $CenterContainer/VBoxContainer/ElixirUsedLabel 

func _ready() -> void:
	var used = GameManager.start_elixir - GameManager.current_elixir
	elixir_label.text = "Elixir used: " + str(used)


func _on_next_level_pressed() -> void:
	if GameManager.aktiver_algorithmus == "SELECTION_SORT":
		get_tree().change_scene_to_file("res://scenes/level_selector2.tscn")
	elif GameManager.aktiver_algorithmus == "BUBBLE_SORT":
		get_tree().change_scene_to_file("res://scenes/level_selector1.tscn")


func _on_retry_pressed() -> void:
	GameManager.current_elixir = GameManager.start_elixir
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
