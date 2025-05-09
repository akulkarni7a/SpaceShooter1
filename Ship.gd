extends Area2D

@export var SPEED: int = 100
const Bullet = preload("res://Bullet.tscn")
var HitEffect = preload("res://HitEffect.tscn") # This was not in the instructions to change, but likely should be const
const ExplosionEffect = preload("res://ExplosionEffect.tscn")

signal player_death

func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= delta * SPEED
	if Input.is_action_pressed("ui_down"):
		position.y += delta * SPEED
	if Input.is_action_just_pressed("ui_accept"):
		fireBullet()
	
func fireBullet():
	var bullet = Bullet.instantiate()
	var main = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	main.add_child(bullet)
	bullet.global_position = global_position

func triggerExplosionEffect():
	var explosion = ExplosionEffect.instantiate()
	var main = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	main.add_child(explosion)
	explosion.global_position = global_position

func _on_Ship_area_entered(area):
	if area.is_in_group("Bullet"):
		pass
	else:
		triggerExplosionEffect()
		area.queue_free()
		queue_free()
		emit_signal("player_death")
