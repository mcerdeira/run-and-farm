extends CharacterBody2D
const SPEED = 300.0
var target = null
var target_obj = null
var type = ""
var tier = null

func initialize(_target, _target_obj, _tier):
	tier = _tier
	target = _target
	target_obj = _target_obj
	velocity = target * SPEED
	$sprite.animation = type

func _physics_process(delta):
	move_and_slide()

func _on_visible_notifier_screen_exited():
	queue_free()

func _on_area_area_entered(area):
	if visible:
		if target_obj == null and area and area.is_in_group("enemies"):
			area.hit()
			visible = false
			queue_free()
		
		if target_obj != null and area and area.is_in_group("cells"):
			if area == target_obj:
				target_obj.notify_plant(tier)
				visible = false
				queue_free()
