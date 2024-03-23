extends Area2D

var state = Global.States.FREE
var tier = null
var growing_time_total = 7.5
var growing_time = growing_time_total
var plant_obj = preload("res://scenes/plant.tscn")
var cell_id = -1

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
		
	if state == Global.States.GROWING:
		grow(delta)
		
func check_neighbors():
	var node1 = get_node("/root/Main/cell" + str(cell_id + 1))
	var node2 = get_node("/root/Main/cell" + str(cell_id - 1))
	var node3 = get_node("/root/Main/cell" + str(cell_id + 10))
	var node4 = get_node("/root/Main/cell" + str(cell_id - 10))
	
	if node1 and node2 and node3 and node4:
		if node1.state == Global.States.FULL_PLANT and node2.state == Global.States.FULL_PLANT and node3.state == Global.States.FULL_PLANT and node4.state == Global.States.FULL_PLANT:
			if node1.tier == tier and node2.tier == tier and node3.tier == tier and node4.tier == tier:
				#TODO: Eliminar todas las plantas y promover la nuestra al tier actual +1
				pass
	
func _on_mouse_entered():
	Global.CURRENT_CELL = self
	if state == Global.States.FREE:
		$AnimationPlayer.play("new_animation")

func _on_mouse_exited():
	if state == Global.States.FREE:
		$AnimationPlayer.play_backwards("new_animation")

func notify_plant(_tier):
	if state == Global.States.FREE:
		growing_time
		tier = _tier
		state = Global.States.GROWING
		$AnimationPlayer.play_backwards("new_animation")
		$Cell.animation = "planted"
		$CellPlanted.visible = true
		$CellPlanted.play("default")
		
func set_free():
	state = Global.States.FREE
	$AnimationPlayer.play_backwards("new_animation")
	$Cell.animation = "default"
	$CellPlanted.visible = false
		
func grow(delta):
	growing_time -= 1 * delta
	if growing_time <= 0:
		growing_time = growing_time_total
		state = Global.States.FULL_PLANT
		
		$Cell.animation = "default"
		$CellPlanted.visible = false
		
		var plant = plant_obj.instantiate()
		plant.position = Vector2(0, 0)
		plant.tier = tier
		add_child(plant)
