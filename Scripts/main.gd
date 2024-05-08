extends Node2D

# Goes to the credits scene
func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

# Goes to the game scene
func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
