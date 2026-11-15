extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -750.0

const GLIDE_GRAVITY = 150.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var sonido_salto = $SonidoSalto
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y > 0 and Input.is_action_pressed("ui_accept"):
			velocity.y += GLIDE_GRAVITY * delta
		else:
			velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sonido_salto.pitch_scale = randf_range(0.9, 1.1)
		sonido_salto.play()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		animated_sprite.play("jump")
	else:
		if direction != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.name == "CapaAgua": 
			get_tree().call_deferred("reload_current_scene")
	move_and_slide()
