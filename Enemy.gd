extends Area2D
@export var ARMOR = 3
var Explosion = preload("res://ExplosionEffect.tscn")

signal scoreUp
signal player_death

var justDied = false
# Note: connect() calls kept using Godot 3 syntax for compatibility.
# Consider refactoring to use await signals or direct callable binding if issues arise.
func _ready():
	var main = get_tree().root # Changed from current_scene
	if main.is_in_group("World"): 
		connect("scoreUp",main,"_on_Enemy_Score_Up")
		connect("player_death",main,"_on_Ship_player_death")

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
		emit_signal("scoreUp")
		justDied = true
		

func triggerExplosion():
	var explosion = Explosion.instantiate()
	var main = get_tree().root # Changed from current_scene
	main.add_child(explosion)
	explosion.global_position = global_position


# Note: This function handles the 'screen_exited' signal. 
# Ensure the corresponding node in the scene is a VisibleOnScreenNotifier2D (Godot 4)
# instead of VisibilityNotifier2D (Godot 3).
func _on_VisibleOnScreenNotifier2D_screen_exited():
	var x = global_position.x
	if x <= 0:
		emit_signal("player_death")
		#shp dies
	queue_free()
