extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_escape_pressed():
	#Change path to that of the MainMenu Scene
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_tutorial_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector1.tscn") # Replace with function body.


func _on_tutorial_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector2.tscn") # Replace with function body.


func _on_tutorial_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selector2.tscn") # Replace with function body.
