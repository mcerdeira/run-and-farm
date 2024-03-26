extends Sprite2D

func _physics_process(delta):
	if Input.is_action_just_pressed("select_up"):
		Global.SelectedSeed += 1
		if Global.SelectedSeed > Global.SeedTiers.WATER:
			Global.SelectedSeed = Global.SeedTiers.D
		
		set_sprite()
		
	if Input.is_action_just_pressed("select_down"):
		Global.SelectedSeed -= 1
		if Global.SelectedSeed < 0:
			Global.SelectedSeed = Global.SeedTiers.WATER

		set_sprite()

func set_sprite():
	$seed.animation = Global.TierSprites[Global.SelectedSeed]
