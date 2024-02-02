extends Node2D

func _physics_process(delta):
	$seed_hud/lbl_seed.text = "x" + str(Global.SEEDS)
