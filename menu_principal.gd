extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level1_1.tscn")



func _on_button_2_pressed() -> void:
	get_tree().quit()



func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Historia.tscn")
