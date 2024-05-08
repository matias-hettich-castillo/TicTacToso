extends Node2D

# Goes back to the main scene
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
