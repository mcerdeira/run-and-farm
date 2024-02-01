extends Area2D
var hitted_ttl = 0
var hitted_ttl_total = 0.3
var life = 3

func _ready():
	add_to_group("enemies")
	$sprite.play("default")

func _physics_process(delta):
	if hitted_ttl > 0:
		hitted_ttl -= 1 * delta
		$sprite.material.set_shader_parameter("hitted", 1)
		if hitted_ttl <= 0:
			$sprite.material.set_shader_parameter("hitted", 0)

func hit():
	if hitted_ttl <= 0:
		hitted_ttl = hitted_ttl_total
		life -= 1
		if life <= 0:
			get_parent().set_free()
			queue_free()
