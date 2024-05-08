extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Goes to the credits scene
func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

# Goes to the game scene
func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
