extends CharacterBody2D
const SPEED = 300.0
var target = null
var type = ""

func _ready():
	target = (get_global_mouse_position() - self.global_position).normalized()
	velocity = target * SPEED
	
func initialize():
	$sprite.animation = type

func _physics_process(delta):
	move_and_slide()
