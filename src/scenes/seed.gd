extends CharacterBody2D
var SPEED = 10.0
var target = null
var taken = false
var tier = Global.SeedTiers.D
var absorved = false
var player = null
var speed = 150

func _ready():
	set_sprite()

func initialize(_target):
	target = _target
	velocity = target * SPEED
	
func set_sprite():
	$sprite.animation = Global.TierSprites[tier]
	
func _physics_process(delta):
	if absorved:
		position = position.move_toward(player.position, delta * speed)
		speed += 1000 * delta
	else:
		if SPEED > 0:
			move_and_slide()
			SPEED -= 10 * delta
			if SPEED <= 0:
				SPEED = 0

func _on_area_area_entered(area):
	if !taken and area and area.is_in_group("players"):
		Global.SEEDS[tier] += 1
		taken = true
		$animation.play("new_animation")

func _on_animation_player_animation_finished(anim_name):
	visible = false
	queue_free()

func _on_magnet_area_entered(area):
	if area and area.is_in_group("players"):
		absorved = true
		player = area
