extends Node

var scoreLabel
var score = 0 : set = set_score

func set_score(value):
	score = value
	if scoreLabel: # Check if scoreLabel is initialized
		scoreLabel.text = "Score: "+str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel = $ScoreLabel
	# Initialize scoreLabel text if score was set before _ready
	if scoreLabel:
		scoreLabel.text = "Score: "+str(score)


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
	get_tree().change_scene("res://GameOverScene.tscn")




