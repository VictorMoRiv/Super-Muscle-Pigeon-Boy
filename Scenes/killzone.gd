extends Node2D


@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print(1) # Replace with function body.
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene() 
