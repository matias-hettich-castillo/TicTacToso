extends Control

# Signal to switch turns
signal next_turn

# Variable that stores this tile value
var tile_value = ""

var tile_blank = true

# Tile icon
@onready var icon = $Icon

func get_tile_value():
	return tile_value

# Called when the player clicks on this tile
func _on_button_pressed():
	print("Tile click: " + str(name))
	if tile_blank:
		print("Tile blank")
		
		# Get wich player's turn is
		var player = $"../../..".get_player()
		
		print("Turn is: " + str(player))
		
		# Set the tiles icon relative to player's turn
		var icon_texture
		if player == "X":
			print("Set tile icon to X")
			tile_value = "X"
			icon_texture = preload("res://Assets/Sprites/Tiles/blue_cross.png")
		else:
			print("Set tile icon to O")
			tile_value = "O"
			icon_texture = preload("res://Assets/Sprites/Tiles/blue_circle.png")
		icon.texture = icon_texture
		
		tile_blank = false
		print("Set tile blank false")
		
		# Check for wining condition
		if $"../../..".check_board(player):
			if player == "X":
				$"../../..".update_status_bar("Player's O turn")
			else:
				$"../../..".update_status_bar("Player's X turn")
			# Emit signal to switch turn
			emit_signal("next_turn")
