extends Area2D
var hitted_ttl = 0
var hitted_ttl_total = 0.3
var life = 3
var seed_obj = preload("res://scenes/seed.tscn")
var tier = Global.SeedTiers.D

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
	var count = 0
	if tier == Global.SeedTiers.D:
		spawn_seed(tier, Vector2(1, -1))
		spawn_seed(tier, Vector2(-1, 1))
		spawn_seed(tier, Vector2(0, 0))
	if tier == Global.SeedTiers.C:
		spawn_seed(Global.SeedTiers.D, Vector2(1, -1))
		spawn_seed(Global.SeedTiers.D, Vector2(-1, 1))
		spawn_seed(tier, Vector2(0, 0))
	if tier == Global.SeedTiers.B:
		spawn_seed(Global.SeedTiers.C, Vector2(1, -1))
		spawn_seed(Global.SeedTiers.C, Vector2(-1, 1))
		spawn_seed(tier, Vector2(0, 0))
	if tier == Global.SeedTiers.A:
		spawn_seed(Global.pick_random([Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(1, -1))
		spawn_seed(Global.pick_random([Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(-1, 1))
		spawn_seed(Global.pick_random([Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(-1,-1))
		spawn_seed(Global.pick_random([Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(1, 1))
		spawn_seed(tier, Vector2(0, 0))
	if tier == Global.SeedTiers.S:
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(1, -1))
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(-1, 1))
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(-1,-1))
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(1, 1))
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(0, 1))
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(1, 0))
		spawn_seed(Global.pick_random([Global.SeedTiers.A, Global.SeedTiers.B, Global.SeedTiers.C, Global.SeedTiers.D]), Vector2(-1, 0))
		spawn_seed(tier, Vector2(0, 0))
		
	get_parent().set_free()
	queue_free()

func spawn_seed(tier, dir):
	var seed = seed_obj.instantiate()
	var root = get_parent().get_parent().get_parent()
	seed.global_position = global_position
	seed.initialize(dir)
	seed.tier = tier
	seed.set_sprite()
	root.add_child(seed)
	
func upgrade():
	if tier != Global.SeedTiers.S:
		tier = Global.SeedTiers.D + 1
		set_sprite()
		
func set_sprite():
	$sprite.animation = Global.TierSprites[tier]

func hit():
	if hitted_ttl <= 0:
		hitted_ttl = hitted_ttl_total
		life -= 1
		if life <= 0:
			die()
			Global.shaker_obj.shake(6, 1)
		else:
			Global.shaker_obj.shake(2, 0.1)
