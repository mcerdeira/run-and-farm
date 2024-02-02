extends CharacterBody2D
var SPEED = 10.0
var target = null

func initialize(_target):
	target = _target
	velocity = target * SPEED
	
func _physics_process(delta):
	if SPEED > 0:
		move_and_slide()
		SPEED -= 10 * delta
		if SPEED <= 0:
			SPEED = 0

func _on_area_area_entered(area):
	if visible and area and area.is_in_group("players"):
		Global.SEEDS += 1
		visible = false
		queue_free()
