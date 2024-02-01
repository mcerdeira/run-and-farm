extends Area2D
enum States {
	FREE,
	GROWING, 
	FULL_PLANT,
}
var state = States.FREE
var seed_type = ""
var growing_time_total = 7.5
var growing_time = growing_time_total
var plant_obj = preload("res://scenes/plant.tscn")

func _ready():
	add_to_group("cells")
	
func _physics_process(delta):
	if state == States.GROWING:
		grow(delta)

func _on_mouse_entered():
	Global.CURRENT_CELL = self
	if state == States.FREE:
		$AnimationPlayer.play("new_animation")

func _on_mouse_exited():
	if state == States.FREE:
		$AnimationPlayer.play_backwards("new_animation")

func notify_plant(_seed_type):
	if state == States.FREE:
		growing_time
		seed_type = _seed_type
		state = States.GROWING
		$AnimationPlayer.play_backwards("new_animation")
		$Cell.animation = "planted"
		$CellPlanted.visible = true
		$CellPlanted.play("default")
		
func set_free():
	state = States.FREE
	$AnimationPlayer.play_backwards("new_animation")
	$Cell.animation = "default"
	$CellPlanted.visible = false
		
func grow(delta):
	growing_time -= 1 * delta
	if growing_time <= 0:
		growing_time = growing_time_total
		state = States.FULL_PLANT
		
		$Cell.animation = "default"
		$CellPlanted.visible = false
		
		var plant = plant_obj.instantiate()
		plant.position = Vector2(0, 0)
		add_child(plant)
