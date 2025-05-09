extends Node

@onready var scoreLabel = $ScoreLabel

var score: int = 0:
	set(value):
		score = value
		if scoreLabel != null: # Check if scoreLabel is valid before using
			scoreLabel.text = "Score: " + str(score)
		else:
			printerr("Error: scoreLabel is null in World.gd. Cannot update score text.")


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize score text in case score is set before scoreLabel is ready
	if scoreLabel != null:
		scoreLabel.text = "Score: " + str(score)
	else:
		# This might happen if the node is not part of the scene tree yet, 
		# or if $ScoreLabel path is incorrect.
		# The setter for score will handle future updates if scoreLabel becomes available.
		pass


func _on_Enemy_Score_Up():
	self.score += 10 # This will use the setter

func updateSaveData():
	var save_data = SaveAndLoad.load_data_from_file()
	if save_data.has("highScore") and score > save_data.highScore:
		#new high score
		save_data.highScore = score
		SaveAndLoad.save_data_to_file(save_data)
	elif not save_data.has("highScore"): # Handle case where highScore might not exist
		save_data.highScore = score
		SaveAndLoad.save_data_to_file(save_data)


func _on_Ship_player_death():
	updateSaveData()
	await get_tree().create_timer(1.0).timeout # Use 1.0 for float time
	get_tree().change_scene_to_file("res://GameOverScene.tscn")
