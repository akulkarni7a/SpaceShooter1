extends Node2D

const Enemy = preload("res://Enemy.tscn")
var spawnPoints

func _ready():
	spawnPoints = $SpawnPoints

func getSpawnPoints():
	var points = spawnPoints.get_children()
	randomize()
	points.shuffle()
	print(points[0].global_position)
	return points[0].global_position
	
func spawnEnemy():
	var spawn_position = getSpawnPoints()
	var enemy = Enemy.instantiate()
	var main = get_tree().get_current_scene()
	main.add_child(enemy)
	enemy.global_position = spawn_position
	

func _on_Timer_timeout():
	spawnEnemy()
	#create enemies 
