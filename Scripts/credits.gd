extends Node2D

# Background music player
@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

# Called when the Credits scene finishes loading
func _ready():
	# Play the background music
	backgroundMusic.play()

# For muting development
func _process(_delta):
	backgroundMusic.stop()

# Called when the back button is pressed
func _on_back_button_button_down():
	# Preload the button press sound effect
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	
	# Play the button press sound effect
	soundEffectPlayer.play()

# Called when the back button is released
func _on_back_button_pressed():
	# Load the Main scene
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
