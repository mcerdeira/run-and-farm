extends Node2D

func _on_area_mouse_entered():
	$AnimationPlayer.play("new_animation")

func _on_area_mouse_exited():
	$AnimationPlayer.play_backwards("new_animation")
