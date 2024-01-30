extends Node2D
var walk_speed = 100

func _ready():
	$sprite.play("idle")
	$eyes.play("idle")

func _physics_process(delta):
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var moving = left or right or up or down
	
	
	if left:
		position.x -= walk_speed * delta
		scale.x = -1
	elif right:
		position.x += walk_speed * delta
		scale.x = 1

	if up:
		position.y -= walk_speed * delta
	elif down:
		position.y += walk_speed * delta
		
	if moving:
		$sprite.animation = "run"
	else:
		$sprite.animation = "idle"
	
