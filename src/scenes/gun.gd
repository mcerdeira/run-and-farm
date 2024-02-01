extends Node2D
var cooldown_total = 0.3
var cooldown = 0
var bullet_obj = preload("res://scenes/player_bullet.tscn")

func _physics_process(delta):
	if cooldown > 0:
		cooldown -= 1 * delta
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("left_shoot"):
		shoot("default")
	if Input.is_action_just_pressed("right_shoot"):
		shoot("seed")
		
func shoot(dir):
	if cooldown <= 0:
		cooldown = cooldown_total
		var bullet = bullet_obj.instantiate()
		bullet.global_position =  $shoot_pos.global_position
		bullet.type = dir
		if dir == "default":
			bullet.initialize((get_global_mouse_position() - self.global_position).normalized(), null)
		elif dir == "seed":
			bullet.initialize((Global.CURRENT_CELL.global_position - self.global_position).normalized(), Global.CURRENT_CELL)
		
		var root = get_parent().get_parent()
		root.add_child(bullet)
