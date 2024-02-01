extends Node2D
var cooldown_total = 0.1
var cooldown = 0
var bullet_obj = preload("res://scenes/player_bullet.tscn")

func _physics_process(delta):
	if cooldown > 0:
		cooldown -= 1 * delta
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("left_shoot"):
		shoot("left")
	if Input.is_action_pressed("right_shoot"):
		shoot("right")
		
func shoot(dir):
	if cooldown <= 0:
		cooldown = cooldown_total
		var bullet = bullet_obj.instantiate()
		bullet.global_position =  $shoot_pos.global_position
		if dir == "left":
			bullet.type = "seed"
		elif dir == "right":
			bullet.type = "default"
		bullet.initialize()
		var root = get_parent().get_parent()
		root.add_child(bullet)
