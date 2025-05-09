extends Node

@onready var highScoreLabel = $HighScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	set_highScore_label()



func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://World.tscn")

func set_highScore_label():
	var save_data = SaveAndLoad.load_data_from_file()
	if save_data.has("highScore"): # Check if highScore key exists
		highScoreLabel.text = "Highscore: "+str(save_data.highScore)
	else:
		highScoreLabel.text = "Highscore: 0" # Default if not found
		printerr("Warning: highScore not found in save_data. Using default.")
