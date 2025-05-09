extends Node2D

const Enemy = preload("res://Enemy.tscn")
@onready var spawnPoints = $SpawnPoints

func getSpawnPoints():
	var points = spawnPoints.get_children()
	# randomize() # Removed as per instructions
	points.shuffle()
	print(points[0].global_position)
	return points[0].global_position
	
func spawnEnemy():
	var spawn_position = getSpawnPoints()
	var enemy = Enemy.instantiate()
	var main = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	if main != null:
		main.add_child(enemy)
		enemy.global_position = spawn_position
	else:
		printerr("Error: Could not spawn enemy. Main scene not found.")
	

func _on_Timer_timeout():
	spawnEnemy()
	#create enemies
