extends Node2D

# Enum for the games turn names
enum {
	TURN_X,
	TURN_O
}

# Variable that stores the current turn
var turn = TURN_X

# Enum for the game state definitions
enum GAME_STATE {
	PLAY,
	GAME_OVER
}

# Variable that stores the current game state
var gameState = GAME_STATE.PLAY

# Array that stores the first row of tiles in the board
var tiles_0 = ["","",""]

# Array that stores the second row of tiles in the board
var tiles_1 = ["","",""]

# Array that stores the third row of tiles in the board
var tiles_2 = ["","",""]

# Variables that point to the tile nodes
@onready var tile_1 = $GamePanel/Board/Tile
@onready var tile_2 = $GamePanel/Board/Tile2
@onready var tile_3 = $GamePanel/Board/Tile3
@onready var tile_4 = $GamePanel/Board/Tile4
@onready var tile_5 = $GamePanel/Board/Tile5
@onready var tile_6 = $GamePanel/Board/Tile6
@onready var tile_7 = $GamePanel/Board/Tile7
@onready var tile_8 = $GamePanel/Board/Tile8
@onready var tile_9 = $GamePanel/Board/Tile9

# Variable that points to the game's status bar node
@onready var statusBar = $GamePanel/GameStatus

# Variable that points to the game over panel node
@onready var gameOverPanel = $GameOverPanel

# Variables that point to the confetti emitters nodes
@onready var leftConfettiEmitter = $LeftConfettiEmitter
@onready var leftConfettiEmitter2 = $LeftConfettiEmitter2
@onready var rightConfettiEmitter = $RightConfettiEmitter
@onready var rightConfettiEmitter2 = $RightConfettiEmitter2

# Background music player
@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

# Called when the Game scene finishes loading
func _ready():
	# Play the background music
	backgroundMusic.play()

# For muting development
func _process(_delta):
	backgroundMusic.stop()

# Called to update the status bar text
func update_status_bar(text):
	# Update the status bar text
	statusBar.text = text

# Called to change the current player's turn
func next_turn():
	# Check the current turn value
	if turn == TURN_X:
		# Set the turn to the O player
		turn = TURN_O
	
	else:
		# Set the turn to the X player
		turn = TURN_X

# Called to get the current turn
func get_player():
	# Check the turn value
	if turn == TURN_X:
		# Return X symbol
		return "X"
	else:
		# Return O symbol
		return "O"

# Called to get the current game state
func get_game_state():
	# Check the current game state
	if gameState == GAME_STATE.PLAY:
		# Return 1 if the game state is PLAY
		return 1
	
	else:
		# Return 0 if the game state is GAME_OVER
		return 0

# Called to disable all tiles of the board
func disable_tiles(is_draw):
	# Disable each tile of the board
	# The variable is_draw is used in case there was a draw
	tile_1.set_disabled(is_draw)
	tile_2.set_disabled(is_draw)
	tile_3.set_disabled(is_draw)
	tile_4.set_disabled(is_draw)
	tile_5.set_disabled(is_draw)
	tile_6.set_disabled(is_draw)
	tile_7.set_disabled(is_draw)
	tile_8.set_disabled(is_draw)
	tile_9.set_disabled(is_draw)

# Called when the game ends in a win state to activate the confetti particle emitter
func shoot_confetti():
	# Activate each confetti particle emitter
	leftConfettiEmitter.emitting = true
	leftConfettiEmitter2.emitting = true
	rightConfettiEmitter.emitting = true
	rightConfettiEmitter2.emitting = true

# Called when the game needs to check check the board for a game over condition
# This function returns true if win or draw condition where not met, so the game
# is still going, and returns false in case a draw or a win condition where met
func check_board(player):
	# Update the first row of tiles array
	tiles_0[0] = tile_1.get_tile_value()
	tiles_0[1] = tile_2.get_tile_value()
	tiles_0[2] = tile_3.get_tile_value()
	
	# Update the second row of tiles array
	tiles_1[0] = tile_4.get_tile_value()
	tiles_1[1] = tile_5.get_tile_value()
	tiles_1[2] = tile_6.get_tile_value()
	
	# Update the third row of tiles array
	tiles_2[0] = tile_7.get_tile_value()
	tiles_2[1] = tile_8.get_tile_value()
	tiles_2[2] = tile_9.get_tile_value()
	
	# Variable that stores the player in case there was a winning condition
	var win_condition = ""
	
	# Variable that stores if there was a draw condition
	var draw_condition = true
	
	# Iterate for each tile
	for i in 3:
		# Check if there is a blank tile
		if tiles_0[i] == "" or tiles_1[i] == "" or tiles_2[i] == "":
			# Set the draw condition false if there was a blank tile somewhere
			draw_condition = false
	
	# Section that checks if the winning conditions where met in any row
	# Check win condition in the first row
	if tiles_0[0] == player and tiles_0[1] == player and tiles_0[2] == player:
		win_condition = player
		tile_1.tile_highlight(true)
		tile_2.tile_highlight(true)
		tile_3.tile_highlight(true)
		
		tile_4.tile_highlight(false)
		tile_5.tile_highlight(false)
		tile_6.tile_highlight(false)
		tile_7.tile_highlight(false)
		tile_8.tile_highlight(false)
		tile_9.tile_highlight(false)
	
	# Check win condition in the second row
	if tiles_1[0] == player and tiles_1[1] == player and tiles_1[2] == player:
		win_condition = player
		tile_4.tile_highlight(true)
		tile_5.tile_highlight(true)
		tile_6.tile_highlight(true)
		
		tile_1.tile_highlight(false)
		tile_2.tile_highlight(false)
		tile_3.tile_highlight(false)
		tile_7.tile_highlight(false)
		tile_8.tile_highlight(false)
		tile_9.tile_highlight(false)
	
	# Check win condition in the third row
	if tiles_2[0] == player and tiles_2[1] == player and tiles_2[2] == player:
		win_condition = player
		tile_7.tile_highlight(true)
		tile_8.tile_highlight(true)
		tile_9.tile_highlight(true)
		
		tile_1.tile_highlight(false)
		tile_2.tile_highlight(false)
		tile_3.tile_highlight(false)
		tile_4.tile_highlight(false)
		tile_5.tile_highlight(false)
		tile_6.tile_highlight(false)
	
	# Section that checks if the winning conditions where met in any column
	# Check win condition in the first column
	if tiles_0[0] == player and tiles_1[0] == player and tiles_2[0] == player:
		win_condition = player
		tile_1.tile_highlight(true)
		tile_4.tile_highlight(true)
		tile_7.tile_highlight(true)
		
		tile_2.tile_highlight(false)
		tile_3.tile_highlight(false)
		tile_5.tile_highlight(false)
		tile_6.tile_highlight(false)
		tile_8.tile_highlight(false)
		tile_9.tile_highlight(false)
	
	# Check win condition in the second column
	if tiles_0[1] == player and tiles_1[1] == player and tiles_2[1] == player:
		win_condition = player
		tile_2.tile_highlight(true)
		tile_5.tile_highlight(true)
		tile_8.tile_highlight(true)
		
		tile_1.tile_highlight(false)
		tile_3.tile_highlight(false)
		tile_4.tile_highlight(false)
		tile_6.tile_highlight(false)
		tile_7.tile_highlight(false)
		tile_9.tile_highlight(false)
	
	# Check win condition in the third column
	if tiles_0[2] == player and tiles_1[2] == player and tiles_2[2] == player:
		win_condition = player
		tile_3.tile_highlight(true)
		tile_6.tile_highlight(true)
		tile_9.tile_highlight(true)
		
		tile_1.tile_highlight(false)
		tile_2.tile_highlight(false)
		tile_4.tile_highlight(false)
		tile_5.tile_highlight(false)
		tile_7.tile_highlight(false)
		tile_8.tile_highlight(false)
	
	# Section that checks if the winning conditions where met in any diagonal
	# Check win condition in the diagonal from left to right
	if tiles_0[0] == player and tiles_1[1] == player and tiles_2[2] == player:
		win_condition = player
		tile_1.tile_highlight(true)
		tile_5.tile_highlight(true)
		tile_9.tile_highlight(true)
		
		tile_2.tile_highlight(false)
		tile_3.tile_highlight(false)
		tile_4.tile_highlight(false)
		tile_6.tile_highlight(false)
		tile_7.tile_highlight(false)
		tile_8.tile_highlight(false)
	
	# Check win condition in the diagonal from right to left
	if tiles_0[2] == player and tiles_1[1] == player and tiles_2[0] == player:
		win_condition = player
		tile_3.tile_highlight(true)
		tile_5.tile_highlight(true)
		tile_7.tile_highlight(true)
		
		tile_1.tile_highlight(false)
		tile_2.tile_highlight(false)
		tile_4.tile_highlight(false)
		tile_6.tile_highlight(false)
		tile_8.tile_highlight(false)
		tile_9.tile_highlight(false)
	
	# Check if any of the above win conditions where met
	if win_condition != "":
		gameState = GAME_STATE.GAME_OVER
		update_status_bar("Player " + player + " wins!")
		gameOverPanel.show()
		shoot_confetti()
		backgroundMusic.stop()
		backgroundMusic.stream = preload("res://Assets/Music/JDSherbert - Minigame Music Pack - Blackjack.ogg")
		backgroundMusic.play()
		
		# Disable all tiles, no draw condition
		disable_tiles(false)
		
		# Return false because of win condition
		return false
	
	# Check if there was a draw condition
	if draw_condition:
		# Set the game state to game over
		gameState = GAME_STATE.GAME_OVER
		
		# Set the status bar to the draw message
		update_status_bar("It's a draw!")
		
		# Show the game over panel
		gameOverPanel.show()
		
		# Stop the background music
		backgroundMusic.stop()
		
		# Preload the draw background music
		backgroundMusic.stream = preload("res://Assets/Music/JDSherbert - Minigame Music Pack - Beach Vibes.ogg")
		
		# Play the background music
		backgroundMusic.play()
		
		# Disable all tiles, draw condition
		disable_tiles(true)
		
		# Return false because of draw condition
		return false
	
	# Return true because win or draw conditions where not met
	return true

# Called when the game changes player's turn
func _on_tile_next_turn():
	# Call the next turn function
	next_turn()

# Called when the exit button is pressed
func _on_exit_button_button_down():
	# Preload the button press sound effect
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	
	# Play the button press sound effect
	soundEffectPlayer.play()

# Called when the exit button is released
func _on_exit_button_pressed():
	# Load the Main scene
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

# Called when the play again button is pressed
func _on_play_again_button_button_down():
	# Preload the button press sound effect
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	
	# Play the button press sound effect
	soundEffectPlayer.play()

# Called when the play again button is pressed
func _on_play_again_button_pressed():
	# Load the Game scene (Works like a scene reload)
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
