extends Button

@onready var soundEffectPlayer = $"../../SFXPlayer"

func _on_button_pressed(event):
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 5.ogg")
	soundEffectPlayer.play()
