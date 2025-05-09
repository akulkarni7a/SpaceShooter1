extends Node

@onready var scoreLabel = $ScoreLabel

var score: int = 0:
	set(value):
		score = value
		if scoreLabel: # Check if scoreLabel is ready
			scoreLabel.text = "Score: " + str(score)
	get:
		return score

# Called when the node enters the scene tree for the first time.
func _ready():
	self.score = 0 # Initialize score to ensure setter is called if scoreLabel is ready

func _on_Enemy_Score_Up():
	self.score += 10

func updateSaveData():
	var save_data = SaveAndLoad.load_data_from_file()
	if score > save_data.highScore:
		#new high score
		save_data.highScore = score
		SaveAndLoad.save_data_to_file(save_data)


func _on_Ship_player_death():
	updateSaveData()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://GameOverScene.tscn")




