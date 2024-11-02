extends Node2D


func _on_top_down_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/TopDown_world.tscn")
