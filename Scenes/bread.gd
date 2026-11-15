extends Area2D

@export_file("*.tscn") var siguiente_nivel: String
@onready var sonido_omg: AudioStreamPlayer2D = $omg

func _ready() -> void:
	# Conecta la señal body_entered por código automáticamente
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Pigeon":
		if siguiente_nivel:
			# 1. Reproduce el sonido y desactiva la colisión
			sonido_omg.pitch_scale = randf_range(0.9, 1.1)
			sonido_omg.play()
			$CollisionShape2D.set_deferred("disabled", true)
			
			# 2. Espera a que termine el sonido
			await sonido_omg.finished
			
			# 3. Cambia de escena
			get_tree().change_scene_to_file(siguiente_nivel)
		else:
			print("Error: No se ha asignado un nivel de destino en el Pan.")
