extends Node2D

@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

func _ready():
	# Play the BGM
	backgroundMusic.play()

# Goes to the credits scene
func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

# Goes to the game scene
func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_credits_button_button_down():
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	soundEffectPlayer.play()


func _on_start_game_button_button_down():
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	soundEffectPlayer.play()
