extends Area2D
@export var ARMOR: int = 3
var Explosion = preload("res://ExplosionEffect.tscn")

signal scoreUp
signal player_death

var justDied = false


func _ready():
	var main = get_tree().root
	if main.is_in_group("World"): 
		scoreUp.connect(main._on_Enemy_Score_Up)
		player_death.connect(main._on_Ship_player_death)

func _process(delta):
	position.x -= (50*delta)


func _on_Enemy_area_entered(area):
	if area.is_in_group("Ship"):
		pass
	else:
		ARMOR -= 1
		area.createHitEffect()
		area.queue_free()
	
	if ARMOR <= 0:
		triggerExplosion()
		area.queue_free()
		queue_free()
		scoreUp.emit()
		justDied = true
		

func triggerExplosion():
	var explosion = Explosion.instantiate()
	var main = get_tree().root
	main.add_child(explosion)
	explosion.global_position = global_position


func _on_VisibilityNotifier2D_screen_exited():
	var x = global_position.x
	if x <= 0:
		player_death.emit()
		#shp dies
	queue_free()
