extends Area2D
@export var ARMOR: int = 3
var Explosion = preload("res://ExplosionEffect.tscn")

signal scoreUp
signal player_death

var justDied = false


func _ready():
	var main = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	# Ensure main is valid and has the expected methods before connecting.
	if main != null and main.has_method("_on_Enemy_Score_Up"): 
		scoreUp.connect(main._on_Enemy_Score_Up)
	else:
		printerr("Error: Could not connect scoreUp signal. Main scene or method not found.")
		
	if main != null and main.has_method("_on_Ship_player_death"):
		player_death.connect(main._on_Ship_player_death)
	else:
		printerr("Error: Could not connect player_death signal. Main scene or method not found.")

func _process(delta):
	position.x -= (50*delta)


func _on_Enemy_area_entered(area):
	if area.is_in_group("Ship"):
		pass
	else:
		ARMOR -= 1
		if area.has_method("createHitEffect"): # Check if the method exists before calling
			area.createHitEffect()
		area.queue_free()
	
	if ARMOR <= 0:
		triggerExplosion()
		# area.queue_free() # This line was already present and might be redundant if the bullet is freed above.
		queue_free()
		emit_signal("scoreUp")
		justDied = true
		

func triggerExplosion():
	var explosion = Explosion.instantiate()
	var main = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	if main != null:
		main.add_child(explosion)
		explosion.global_position = global_position
	else:
		printerr("Error: Could not trigger explosion. Main scene not found.")


func _on_VisibleOnScreenNotifier2D_screen_exited():
	var x = global_position.x
	if x <= 0:
		emit_signal("player_death")
		#shp dies
	queue_free()
