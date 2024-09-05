extends Control

# Signal to switch the active player
signal next_turn

# Variable that stores this tile value (X or O)
var tile_value = ""

# Variable that stores if the tile is blank or not
var tile_blank = true

# Variable that points to the icon Node of the tile
@onready var icon = $Icon

# Variable that points to the button Node of the tile
@onready var button = $Button

# Sound effect player
@onready var soundEffectPlayer = $"../../../SFXPlayer"

# Called when the Tile Node finishes loading
func _ready():
	# Update the tile button tooltip text
	button.tooltip_text = "Place a token by clicking here."

# Called when the player clicks on the button Node of the tile
func _on_button_pressed():
	# Check if the tile was previously blank
	if tile_blank:
		# Preload the tile button press sound effect
		soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Select - 1.ogg")
		
		# Play the button press sound effect
		soundEffectPlayer.play()
		
		# Get wich one is the active player
		var player = $"../../..".get_player()
		
		# Variable that stores the icon texture to show later
		var icon_texture
		
		# Check the active player's value to set the tile value and icon texture
		if player == "X":
			# Set the tile value to the X symbol
			tile_value = "X"
			
			# Preload the X icon
			icon_texture = preload("res://Assets/Sprites/Tiles/blue_cross.png")
		else:
			# Set the tile value to the O symbol
			tile_value = "O"
			
			# Preload the circle icon
			icon_texture = preload("res://Assets/Sprites/Tiles/blue_circle.png")
		
		# Set icon node texture
		icon.texture = icon_texture
		
		# Set this tile blank variable to false
		tile_blank = false
		
		# Check if there wasn't a win or draw conditions
		if $"../../..".check_board(player):
			# Check wich is the active player
			if player == "X":
				# Update the status bar turn display
				$"../../..".update_status_bar("Player's O turn")
			
			else:
				# Update the status bar turn display
				$"../../..".update_status_bar("Player's X turn")
			
			# Emit signal to inform turn change
			emit_signal("next_turn")

# Called when the tile button node is disabled
func set_disabled(is_draw):
	# Check if there was a draw condition
	if is_draw:
		# Variable that stores the icon texture to show later
		var icon_texture
		
		# Check the tile symbol value
		if tile_value == "X":
			# Preload the icon texture
			icon_texture = preload("res://Assets/Sprites/Tiles/yellow_cross.png")
		
		else:
			# Preload the icon texture
			icon_texture = preload("res://Assets/Sprites/Tiles/yellow_circle.png")
		
		# Set icon node texture
		icon.texture = icon_texture
	
	# Disable the button node of the tile
	button.set_disabled(true)

# Returns the tile symbol value
func get_tile_value():
	return tile_value

# Sets the tile value for the cpu move
func set_cpu_move_tile_value():
	# Variable that stores the icon texture to show later
	var icon_texture
	
	# Set the tile value to the O symbol
	tile_value = "O"

	# Preload the circle icon
	icon_texture = preload("res://Assets/Sprites/Tiles/blue_circle.png")

	# Set icon node texture
	icon.texture = icon_texture

	# Set this tile blank variable to false
	tile_blank = false
	
	# Check if there wasn't a win or draw conditions
	if $"../../..".check_board("O"):
		# Update the status bar turn display
		$"../../..".update_status_bar("Player's X turn")

# Called when the tile icon node is highlighted with the win or lose colors
func tile_highlight(win):
	# Check if the tile has a icon symbol
	if !tile_blank:
		# Variable that stores the icon texture to show later
		var icon_texture
		
		# Check the tile symbol value
		if tile_value == "X":
			# Check if this tile is part of the wining ones
			if win:
				# Preload the green icon texture
				icon_texture = preload("res://Assets/Sprites/Tiles/green_cross.png")
			
			else:
				# Preload the red icon texture
				icon_texture = preload("res://Assets/Sprites/Tiles/red_cross.png")
		
		elif tile_value == "O":
			# Check if this tile is part of the wining ones
			if win:
				# Preload the green icon texture
				icon_texture = preload("res://Assets/Sprites/Tiles/green_circle.png")
			
			else:
				# Preload the red icon texture
				icon_texture = preload("res://Assets/Sprites/Tiles/red_circle.png")
		
		# Set the icon node texture
		icon.texture = icon_texture
