extends Node2D

# Background music player
@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

# Called when the Main scene finishes loading
func _ready():
	# Play the background music
	backgroundMusic.play()

# Called when the Start Game button is pressed
func _on_start_game_button_button_down():
	# Preload the button press sound effect
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	
	# Play the button press sound effect
	soundEffectPlayer.play()

# Called when the Start Game button is released
func _on_start_game_button_pressed():
	# Load the Game scene
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

# Called when the Credits button is pressed
func _on_credits_button_button_down():
	# Preload the button press sound effect
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	
	# Play the button press sound effect
	soundEffectPlayer.play()

# Called when the Credits button is released
func _on_credits_button_pressed():
	# Load the Credits scene
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
