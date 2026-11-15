extends Camera2D

@export var velocidad_transicion: float = 10.0
@onready var jugador = get_parent().get_node_or_null("Pigeon")

var y_fija: float

func _ready() -> void:
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	y_fija = global_position.y
	
	if jugador:
		var tamano_real = get_viewport_rect().size / zoom
		var fase_x = floor(jugador.global_position.x / tamano_real.x)
		global_position = Vector2(fase_x * tamano_real.x, y_fija)

func _process(delta: float) -> void:
	if not jugador:
		return
	
	var tamano_real = get_viewport_rect().size / zoom
	var fase_x = floor(jugador.global_position.x / tamano_real.x)
	
	var posicion_objetivo = Vector2(fase_x * tamano_real.x, y_fija)
	
	global_position = global_position.lerp(posicion_objetivo, velocidad_transicion * delta)
