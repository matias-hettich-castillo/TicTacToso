extends Node2D

# Background music player
@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

# Called when the Main scene finishes loading
func _ready():
	# Play the background music
	backgroundMusic.play()

# Called to play a clicky sound
func play_click_sound():
	# Preload the button press sound effect
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	
	# Play the button press sound effect
	soundEffectPlayer.play()

# Called when the Start Game button is pressed
func _on_start_game_button_button_down():
	play_click_sound()

# Called when the Credits button is pressed
func _on_credits_button_button_down():
	play_click_sound()

# Called when the Vs Cpu button is pressed
func _on_start_cpu_button_button_down():
	play_click_sound()

# Called when the Start Game button is released
func _on_start_game_button_pressed():
	# Load the Game scene
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

# Called when the Credits button is released
func _on_credits_button_pressed():
	# Load the Credits scene
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

# Called when the Vs Cpu button is released
func _on_start_cpu_button_pressed():
	# Load the vs cpu mode scene
	get_tree().change_scene_to_file("res://Scenes/vscpu.tscn")
