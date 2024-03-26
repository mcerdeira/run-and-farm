extends Node2D

func _physics_process(delta):
	$seed_hud/lbl_seed.text = "x" + str(Global.SEEDS[Global.SeedTiers.D])
	$seed_hud1/lbl_seed.text = "x" + str(Global.SEEDS[Global.SeedTiers.C])
	$seed_hud2/lbl_seed.text = "x" + str(Global.SEEDS[Global.SeedTiers.B])
	$seed_hud3/lbl_seed.text = "x" + str(Global.SEEDS[Global.SeedTiers.A])
	$seed_hud4/lbl_seed.text = "x" + str(Global.SEEDS[Global.SeedTiers.S])
