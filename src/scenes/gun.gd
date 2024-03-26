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
	if Input.is_action_pressed("right_shoot"):
		if Global.SEEDS[Global.SelectedSeed] > 0:
			if Global.CURRENT_CELL and Global.CURRENT_CELL.state == Global.States.FREE:
				tier = Global.SelectedSeed
				shoot("seed", tier)
		elif Global.SelectedSeed == Global.SeedTiers.WATER:
			tier = Global.SelectedSeed
			shoot("water", tier)
				
func shoot(dir, tier = null):
	if dir == "water":
		if cooldown <= 0:
			cooldown = Global.pick_random([0.1, 0, 0])
			var bullet = bullet_obj.instantiate()
			bullet.global_position =  $shoot_pos.global_position
			bullet.type = dir
			bullet.initialize((get_global_mouse_position() - self.global_position).normalized(), null, tier)

			var root = get_parent().get_parent()
			root.add_child(bullet)
		
	elif cooldown <= 0:
		cooldown = cooldown_total
		var bullet = bullet_obj.instantiate()
		bullet.global_position =  $shoot_pos.global_position
		bullet.type = dir
		Global.shaker_obj.shake(2, 0.1)
		if dir == "default":
			bullet.initialize((get_global_mouse_position() - self.global_position).normalized(), null, null)
		elif dir == "seed":
			Global.SEEDS[Global.SelectedSeed] -= 1
			bullet.initialize((Global.CURRENT_CELL.global_position - self.global_position).normalized(), Global.CURRENT_CELL, tier)
		
		var root = get_parent().get_parent()
		root.add_child(bullet)
