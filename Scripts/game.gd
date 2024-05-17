extends Node2D



# Used to track the player's turn
enum {
	TURN_X,
	TURN_O
}
var turn = TURN_X

# Used to track the game state
enum GAME_STATE {
	PLAY,
	GAME_OVER
}
var gameState = GAME_STATE.PLAY

# Array that stores the tiles played in the game
var tiles_0 = ["","",""]
var tiles_1 = ["","",""]
var tiles_2 = ["","",""]

# Get access to the game tiles
@onready var tile_1 = $GamePanel/Board/Tile
@onready var tile_2 = $GamePanel/Board/Tile2
@onready var tile_3 = $GamePanel/Board/Tile3
@onready var tile_4 = $GamePanel/Board/Tile4
@onready var tile_5 = $GamePanel/Board/Tile5
@onready var tile_6 = $GamePanel/Board/Tile6
@onready var tile_7 = $GamePanel/Board/Tile7
@onready var tile_8 = $GamePanel/Board/Tile8
@onready var tile_9 = $GamePanel/Board/Tile9

# Game's status bar, used to inform the player about turns
@onready var statusBar = $GamePanel/GameStatus

# Game over panel
@onready var gameOverPanel = $GameOverPanel

# Confetti emitters
@onready var leftConfettiEmitter = $LeftConfettiEmitter
@onready var rightConfettiEmitter = $RightConfettiEmitter

# Background music
@onready var backgroundMusic = $BackgroundMusic

# Sound effect player
@onready var soundEffectPlayer = $SFXPlayer

func _ready():
	backgroundMusic.play()

func update_status_bar(text):
	statusBar.text = text

# Called when a player's turn end
func next_turn():
	if turn == TURN_X:
		turn = TURN_O
	else:
		turn = TURN_X

# Called to get the player's turn
func get_player():
	if turn == TURN_X:
		return "X"
	else:
		return "O"

func get_game_state():
	if gameState == GAME_STATE.PLAY:
		return 1
	else:
		return 0

func disable_tiles(is_draw):
	tile_1.set_disabled(is_draw)
	tile_2.set_disabled(is_draw)
	tile_3.set_disabled(is_draw)
	tile_4.set_disabled(is_draw)
	tile_5.set_disabled(is_draw)
	tile_6.set_disabled(is_draw)
	tile_7.set_disabled(is_draw)
	tile_8.set_disabled(is_draw)
	tile_9.set_disabled(is_draw)

func shoot_confetti():
	leftConfettiEmitter.emitting = true
	rightConfettiEmitter.emitting = true

# Called to check the board for game over conditions
func check_board(player):
	print("begin check board")
	print("update tile values")
	# Update the first row of tile arrays
	tiles_0[0] = tile_1.get_tile_value()
	tiles_0[1] = tile_2.get_tile_value()
	tiles_0[2] = tile_3.get_tile_value()
	
	# Update the second row of tile arrays
	tiles_1[0] = tile_4.get_tile_value()
	tiles_1[1] = tile_5.get_tile_value()
	tiles_1[2] = tile_6.get_tile_value()
	
	# Update the third row of tile arrays
	tiles_2[0] = tile_7.get_tile_value()
	tiles_2[1] = tile_8.get_tile_value()
	tiles_2[2] = tile_9.get_tile_value()
	
	print("checking player: " + str(player))
	var win_condition = ""
	
	# Check draw condition
	print("Check draw condition")
	var draw_condition = true
	for i in 3:
		if tiles_0[i] == "" or tiles_1[i] == "" or tiles_2[i] == "":
			print("Row " + str(i) + " there's a free space")
			draw_condition = false
	
	if draw_condition:
		gameState = GAME_STATE.GAME_OVER
		update_status_bar("It's a draw!")
		shoot_confetti()
		gameOverPanel.show()
		backgroundMusic.stop()
		backgroundMusic.stream = preload("res://Assets/Music/JDSherbert - Minigame Music Pack - Beach Vibes.ogg")
		backgroundMusic.play()
		
		# lock tiles
		disable_tiles(true)
		
		return false
	
	print("begin check columns")
	# Check columns
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
	
	print("begin check rows")
	# Check rows
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
	
	print("begin check cross")
	# Check cross
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
	
	print("check win condition")
	if win_condition != "":
		gameState = GAME_STATE.GAME_OVER
		update_status_bar("Player " + player + " wins!")
		gameOverPanel.show()
		shoot_confetti()
		backgroundMusic.stop()
		backgroundMusic.stream = preload("res://Assets/Music/JDSherbert - Minigame Music Pack - Blackjack.ogg")
		backgroundMusic.play()
		
		# Lock tiles
		disable_tiles(false)
		
		return false
		
	return true

# Goes back to the main scene
func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

# Called at the end of the player's turn
func _on_tile_next_turn():
	next_turn()

# Reloads the game scene
func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_play_again_button_button_down():
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	soundEffectPlayer.play()


func _on_exit_button_button_down():
	soundEffectPlayer.stream = preload("res://Assets/SFX/JDSherbert - Ultimate UI SFX Pack - Cursor - 3.ogg")
	soundEffectPlayer.play()
