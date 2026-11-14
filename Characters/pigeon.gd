extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Gravedad suave para cuando esté planeando
const GLIDE_GRAVITY = 150.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Referencia a tu nodo AnimatedSprite2D hijo
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. Gravedad y planeo
	if not is_on_floor():
		if velocity.y > 0 and Input.is_action_pressed("ui_accept"):
			velocity.y += GLIDE_GRAVITY * delta
		else:
			velocity.y += gravity * delta

	# 2. Salto normal
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Movimiento horizontal y giro del sprite
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Gestión de Animaciones
	if not is_on_floor():
		# Si está en el aire (saltando, cayendo o planeando)
		animated_sprite.play("jump")
	else:
		if direction != 0:
			# Si se está moviendo en el suelo
			animated_sprite.play("walk")
		else:
			# Si está quieto
			animated_sprite.play("idle")

	move_and_slide()
