extends Node2D

# Background Music
@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

func _ready():
	backgroundMusic.play()

# Goes back to the main scene
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_back_button_button_down():
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	soundEffectPlayer.play()
