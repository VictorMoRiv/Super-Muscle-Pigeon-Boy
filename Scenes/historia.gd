extends Control

# Obtenemos los nodos hijos que pusiste en la escena (1, 2, 3 y 4)
@onready var diapositivas: Array[Node] = [$ "1", $ "2", $ "3", $ "4"]
var indice_actual: int = 0

func _ready() -> void:
	$Timer.wait_time = 10.0
	$Timer.autostart = true
	
	# Oculta todas las diapositivas al inicio y muestra solo la primera
	actualizar_diapositivas()

func _on_timer_timeout() -> void:
	indice_actual += 1
	
	if indice_actual < diapositivas.size():
		actualizar_diapositivas()
	else:
		# Si se acaban las diapositivas, regresa al menú principal
		get_tree().change_scene_to_file("res://Scenes/StarScreen.tscn")

func actualizar_diapositivas() -> void:
	for i in range(diapositivas.size()):
		if i == indice_actual:
			diapositivas[i].visible = true  # Muestra la actual
		else:
			diapositivas[i].visible = false # Oculta las demás
