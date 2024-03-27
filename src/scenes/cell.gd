extends Area2D
var current_plant = null
var state = Global.States.FREE
var tier = null
var growing_time_total = 7.5
var growing_time = growing_time_total
var plant_obj = preload("res://scenes/plant.tscn")
var cell_id = -1
var watered = false
var water = 0
var water_total = 0.3

func set_water():
	if water < water_total: 
		water += 0.009
		if water >= water_total:
			$CellPlanted.play(Global.TierSprites[tier])
			watered = true

func _ready():
	add_to_group("cells")
	var nameid = name.split("")
	var id = nameid[4]
	if nameid.size() == 6:
		id += nameid[5]
		
	cell_id = int(id)
	
func _physics_process(delta):
	if state == Global.States.FULL_PLANT:
		check_neighbors()
	
	if water > 0:
		$Watered.self_modulate.a = min(water, water_total)
		
	$Watered.visible = watered or water > 0
		
	if state == Global.States.GROWING and watered:
		grow(delta)
		
func check_neighbors():
	var node1 = get_node("/root/Main/cell" + str(cell_id + 1))
	var node2 = get_node("/root/Main/cell" + str(cell_id - 1))
	var node3 = get_node("/root/Main/cell" + str(cell_id + 10))
	var node4 = get_node("/root/Main/cell" + str(cell_id - 10))
	
	if node1 and node2 and node3 and node4:
		if node1.state == Global.States.FULL_PLANT and node2.state == Global.States.FULL_PLANT and node3.state == Global.States.FULL_PLANT and node4.state == Global.States.FULL_PLANT:
			if node1.tier == tier and node2.tier == tier and node3.tier == tier and node4.tier == tier:
				node1.destroy()
				node2.destroy()
				node3.destroy()
				node4.destroy()
				upgrade()
				
func upgrade():
	if tier != Global.SeedTiers.S:
		tier += 1

	current_plant.upgrade()
	
func destroy():
	if current_plant and is_instance_valid(current_plant):
		state = Global.States.FREE 
		current_plant.queue_free()
		current_plant = null
	
func _on_mouse_entered():
	Global.CURRENT_CELL = self
	#if state == Global.States.FREE or state == Global.States.FULL_PLANT:
	$AnimationPlayer.play("new_animation")

func _on_mouse_exited():
	$AnimationPlayer.play_backwards("new_animation")

func notify_plant(_tier):
	if state == Global.States.FREE:
		growing_time
		tier = _tier
		state = Global.States.GROWING
		watered = false
		water = 0
		$AnimationPlayer.play_backwards("new_animation")
		$Cell.animation = "planted"
		$CellPlanted.visible = true
		$CellPlanted.animation = Global.TierSprites[tier]
		$CellPlanted.stop()
		
func set_free():
	state = Global.States.FREE
	$AnimationPlayer.play_backwards("new_animation")
	$Cell.animation = "default"
	$CellPlanted.visible = false
	watered = false
	water = 0
		
func grow(delta):
	growing_time -= 1 * delta
	if growing_time <= 0:
		growing_time = growing_time_total
		state = Global.States.FULL_PLANT
		watered = false
		water = 0
		
		$Cell.animation = "default"
		$CellPlanted.visible = false
		
		current_plant = plant_obj.instantiate()
		current_plant.position = Vector2(0, 0)
		current_plant.tier = tier
		current_plant.set_sprite()
		add_child(current_plant)
