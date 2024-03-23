extends Node2D
var cooldown_total = 0.3
var cooldown = 0
var bullet_obj = preload("res://scenes/player_bullet.tscn")
var tier = Global.SeedTiers.D

func _physics_process(delta):
	if cooldown > 0:
		cooldown -= 1 * delta
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("left_shoot"):
		shoot("default")
	if Input.is_action_just_pressed("right_shoot"):
		if Global.SEEDS > 0:
			if Global.CURRENT_CELL and Global.CURRENT_CELL.state == Global.States.FREE:
				shoot("seed", tier)
		
func shoot(dir, tier = null):
	if cooldown <= 0:
		cooldown = cooldown_total
		var bullet = bullet_obj.instantiate()
		bullet.global_position =  $shoot_pos.global_position
		bullet.type = dir
		Global.shaker_obj.shake(2, 0.1)
		if dir == "default":
			bullet.initialize((get_global_mouse_position() - self.global_position).normalized(), null, null)
		elif dir == "seed":
			Global.SEEDS -= 1
			bullet.initialize((Global.CURRENT_CELL.global_position - self.global_position).normalized(), Global.CURRENT_CELL, tier)
		
		var root = get_parent().get_parent()
		root.add_child(bullet)
