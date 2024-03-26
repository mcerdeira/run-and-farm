extends CharacterBody2D
const SPEED = 300.0
var target = null
var target_obj = null
var type = ""
var tier = null
var ttl = 0.1

func initialize(_target, _target_obj, _tier):
	tier = _tier
	target = _target
	target_obj = _target_obj
	velocity = target * SPEED
	set_sprite()
	
func set_sprite():
	if tier != null:
		$sprite.animation = Global.TierSprites[tier]

func _physics_process(delta):
	if tier == Global.SeedTiers.WATER:
		ttl -= 1 * delta
		if ttl <= 0:
			queue_free()
	move_and_slide()

func _on_visible_notifier_screen_exited():
	queue_free()

func _on_area_area_entered(area):
	if visible:
		if tier == Global.SeedTiers.WATER:
			if area and area.is_in_group("cells"):
				if area.state == Global.States.GROWING and area.watered == false:
					area.set_water()
		else:
			if target_obj == null and area and area.is_in_group("enemies"):
				area.hit()
				visible = false
				queue_free()
			
			if target_obj != null and area and area.is_in_group("cells"):
				if area == target_obj:
					target_obj.notify_plant(tier)
					visible = false
					queue_free()
