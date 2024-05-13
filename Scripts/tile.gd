extends Control

# Signal to switch turns
signal next_turn

# Variable that stores this tile value
var tile_value = ""

var tile_blank = true

# Tile icon
@onready var icon = $Icon

# Tile button
@onready var button = $Button

func set_disabled(is_draw):
	if is_draw:
		var icon_texture
		if tile_value == "X":
			icon_texture = preload("res://Assets/Sprites/Tiles/yellow_cross.png")
		else:
			icon_texture = preload("res://Assets/Sprites/Tiles/yellow_circle.png")
		icon.texture = icon_texture
	button.set_disabled(true)

func get_tile_value():
	return tile_value

func tile_highlight(win):
	if !tile_blank:
		var icon_texture
		if tile_value == "X":
			if win:
				icon_texture = preload("res://Assets/Sprites/Tiles/green_cross.png")
			else:
				icon_texture = preload("res://Assets/Sprites/Tiles/red_cross.png")
		elif tile_value == "O":
			if win:
				icon_texture = preload("res://Assets/Sprites/Tiles/green_circle.png")
			else:
				icon_texture = preload("res://Assets/Sprites/Tiles/red_circle.png")
		icon.texture = icon_texture

# Called when the player clicks on this tile
func _on_button_pressed():
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
