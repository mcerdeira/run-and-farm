extends Area2D
var hitted_ttl = 0
var hitted_ttl_total = 0.3
var life = 3
var seed_obj = preload("res://scenes/seed.tscn")

func _ready():
	add_to_group("enemies")
	$sprite.play("default")

func _physics_process(delta):
	if hitted_ttl > 0:
		hitted_ttl -= 1 * delta
		$sprite.material.set_shader_parameter("hitted", 1)
		if hitted_ttl <= 0:
			$sprite.material.set_shader_parameter("hitted", 0)
			
func die():
	var count = Global.pick_random([1, 2, 2])
	spawn_seed(count)
	get_parent().set_free()
	queue_free()

func spawn_seed(count):
	var dir = [Vector2(1, -1), Vector2(-1, 1)]
	for i in count:
		var seed = seed_obj.instantiate()
		var root = get_parent().get_parent().get_parent()
		seed.global_position = global_position
		seed.initialize(dir[i])
		root.add_child(seed)

func hit():
	if hitted_ttl <= 0:
		hitted_ttl = hitted_ttl_total
		life -= 1
		if life <= 0:
			die()
			Global.shaker_obj.shake(6, 1)
		else:
			Global.shaker_obj.shake(2, 0.1)
